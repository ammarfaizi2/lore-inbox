Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbVKIQq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbVKIQq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVKIQqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:46:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:31963 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751458AbVKIQqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:46:25 -0500
Date: Wed, 9 Nov 2005 08:45:44 -0800
From: Greg KH <greg@kroah.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/39] NLKD - early/late CPU up/down notification
Message-ID: <20051109164544.GB32068@kroah.com>
References: <43720DAE.76F0.0078.0@novell.com> <43720E2E.76F0.0078.0@novell.com> <43720E72.76F0.0078.0@novell.com> <43720EAF.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43720EAF.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 02:58:55PM +0100, Jan Beulich wrote:
> A mechanism to allow debuggers to learn about starting/dying CPUs as
> early/late as possible. Arch-dependent changes for i386 and x86_64
> will follow.
> 
> Signed-Off-By: Jan Beulich <jbeulich@novell.com>
> 
> (actual patch attached)

Ick, but it's in base64 mode, so I can't quote it to say that your
#ifdef in the .h file is not needed.  Please fix your email client to
send patches properly.

thanks,

greg k-h
