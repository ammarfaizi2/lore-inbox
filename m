Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263864AbUEHAWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUEHAWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUEHAWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:22:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:42371 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263864AbUEHAVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:21:32 -0400
Date: Fri, 7 May 2004 15:00:14 -0700
From: Greg KH <greg@kroah.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Message-ID: <20040507220014.GI13511@kroah.com>
References: <c6od9g$53k$1@gatekeeper.tmr.com> <s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net> <20040504223550.GA32155@kroah.com> <s5gy8o7bnhv.fsf@patl=users.sf.net> <20040505025602.GA19873@kroah.com> <s5gpt9jexwg.fsf@patl=users.sf.net> <20040505224534.GB30345@kroah.com> <s5gk6zpso2m.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gk6zpso2m.fsf@patl=users.sf.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 09:54:04AM -0400, Patrick J. LoPresti wrote:
> So I guess I have two questions:
> 
>   1) Would you be willing to consider patches which address this
>      issue?  Or do you just consider it irrelevant?

I do consider it irrelevant, but let's see the patches anyway.  I can
usually be persuaded to change my mind with a good, clean,
implementation...

>   2) As I said, I have not dived into the source code yet.  Any
>      suggestions for where to start?

drivers/base/*

Good luck...

greg k-h
