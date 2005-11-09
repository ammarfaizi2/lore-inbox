Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVKIQu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVKIQu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVKIQu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:50:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932092AbVKIQu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:50:27 -0500
Date: Wed, 9 Nov 2005 08:50:00 -0800
From: Greg KH <greg@kroah.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/39] NLKD - early panic notification
Message-ID: <20051109164959.GC32068@kroah.com>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com> <43720F5E.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43720F5E.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 03:01:50PM +0100, Jan Beulich wrote:
> A mechanism to allow debuggers to intercept panic events early.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

EXPORT_SYMBOL_GPL() for any new exports you are adding please.

thanks,

greg k-h
