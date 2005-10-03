Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVJCQF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVJCQF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 12:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVJCQF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 12:05:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:34695 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932346AbVJCQF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 12:05:27 -0400
Date: Mon, 3 Oct 2005 09:04:52 -0700
From: Greg KH <greg@kroah.com>
To: Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, jgarzik@pobox.com,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org, zaitcev@redhat.com,
       coywolf@gmail.com
Subject: Re: [PATCH] Document patch subject line better
Message-ID: <20051003160452.GA9107@kroah.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com> <Pine.LNX.4.64.0510030805380.31407@g5.osdl.org> <20051003085414.05468a2b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003085414.05468a2b.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 08:54:14AM -0700, Paul Jackson wrote:
> 
> Ideally either I should change my patch sending process, or I should
> change quilt. 

Change quilt.  I have a horrible patch to my local copy of quilt that
adds this line, it's not hard to do.

I'll work on cleaning it up and getting the change into the upstream
version of quilt this week.

thanks,

greg k-h
