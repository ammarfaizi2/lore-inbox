Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUKFBAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUKFBAs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUKFBAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:00:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:58529 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261300AbUKFBAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:00:38 -0500
Date: Fri, 5 Nov 2004 17:00:16 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify: add FIONREAD support
Message-ID: <20041106010016.GA11866@kroah.com>
References: <1099696444.6034.266.camel@localhost> <20041106004755.GA23981@kroah.com> <1099702663.6034.270.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099702663.6034.270.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 07:57:43PM -0500, Robert Love wrote:
> On Fri, 2004-11-05 at 16:47 -0800, Greg KH wrote:
> 
> > But sparse will spit out warnings with code like this :(
> 
> Why?  p is annotated __user.

Ah, ok, nevermind.

greg k-h
