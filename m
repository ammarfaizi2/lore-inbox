Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTIZSDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTIZSDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:03:32 -0400
Received: from mail.kroah.org ([65.200.24.183]:49099 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261468AbTIZSDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:03:31 -0400
Date: Fri, 26 Sep 2003 11:03:27 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?B=F6rkur_Ingi_J=F3nsson?= <bugsy@isl.is>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Message-ID: <20030926180327.GA5204@kroah.com>
References: <200309261724.56616.bugsy@isl.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309261724.56616.bugsy@isl.is>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 05:24:56PM +0000, Börkur Ingi Jónsson wrote:
> Ps. in english this means that. On my computer khubd is using 100% of my 
> cpu... any fix on this?

As I asked for in your bugzilla.kernel.org filing, what does the kernel
log showing?  Is there lots of USB activity?  Are there any USB devices
plugged into the system?  Does this also happen for 2.4?  Are you using
ACPI?  (I can go on, but that's a good start.  You need to provide a
much better bug report than this...)

greg k-h
