Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUJVVIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUJVVIb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267566AbUJVVHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:07:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:32727 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267554AbUJVU7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:59:47 -0400
Date: Fri, 22 Oct 2004 13:58:51 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linus@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect against buggy drivers
Message-ID: <20041022205851.GA25042@kroah.com>
References: <1097254421.16787.27.camel@localhost.localdomain> <20041008171414.GA28001@kroah.com> <1097260045.16787.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097260045.16787.59.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 11:27:25AM -0700, Stephen Hemminger wrote:
> Here is a better fix (thanks Greg) that allows long names for character
> device objects.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

Applied, thanks.

greg k-h
