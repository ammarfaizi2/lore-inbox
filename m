Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTL1P1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 10:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbTL1P1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 10:27:14 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:15496
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S261552AbTL1P1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 10:27:13 -0500
Date: Sun, 28 Dec 2003 10:27:11 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is it possible to have a kernel module with a BSD license?!
Message-ID: <20031228152711.GE17870@michonline.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FE9ADEE.1080103@baywinds.org> <20031227145102.GA14464@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227145102.GA14464@hh.idb.hist.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snipping a bit to keep this succint]

On Sat, Dec 27, 2003 at 03:51:02PM +0100, Helge Hafting wrote:
> > About:
> > This project provides a kernel module which provides 3rd-party 
> > applications with an interface for file access control. It was 
> > originally developed for on-access virus scanning. Other uses include a 
> 
> "On access" seems to be exactly the wrong moment for a virus check - 
> that way you are getting the check delay at the worst moment, when
> the user actually want to use the file.  
> 
> Consider doing virus checking on write only, viruses spread
> only at that time.  

So, when I stick my nicely virus infected floppy/cdrom/etc into your
machine, and your write-only virus scan gets disabled by my module
patching virus...

So, when I stick my nicely virus infected floppy/cdrom/etc into your
machine, and your write-only virus scan gets disabled by the module
the virus loads...


-- 

Ryan Anderson
  sometimes Pug Majere
