Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUIALP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUIALP1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 07:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUIALP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 07:15:27 -0400
Received: from bay18-f27.bay18.hotmail.com ([65.54.187.77]:14354 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S266128AbUIALPZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 07:15:25 -0400
X-Originating-IP: [67.0.155.180]
X-Originating-Email: [codermattie@hotmail.com]
From: "michael mattie" <codermattie@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Date: Wed, 01 Sep 2004 11:15:23 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F27NQ6MHZJas50001c6ae@hotmail.com>
X-OriginalArrivalTime: 01 Sep 2004 11:15:24.0360 (UTC) FILETIME=[FA239C80:01C49014]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In reading this thread I have not found one example *app* that cannot be 
implemented in XML. From
my understanding the big win of hybrid files is that they expose the 
structure of files to the Unix toolset.
Assume that this is possible and you can cd through the structure, you have 
acheived zero code sharing, only a never ending job of intergrating a 
infinite list of format interpreters. With XML you have a
concesus on syntax (structure) that is independant of the semantics and a 
significant and error
prone chunk of code can be shoved into a userspace library. I don't see 
anything like this in
hybrid files.

So far the vision I see in this thread for hybrid files is icons, mime 
types, character encoding, thumb nails, and meta data ? This is hetrogenous 
content ! I see no win in a VFS interface to a ad-hoc poor re-implementation 
of w3.org. I do admit it can be exciting to cd through the internal 
structure of a file, I do it all the time with Xpath and XSH [ see 
http://xsh.sourceforge.net/ ] from CPAN. The big win
of hybrid files can be had with a install. Transparent traversals of archive 
files should be shoved
into the shell with all of the other ugly hacks where it can be caged and 
easily killed with a signal.
Even windows programmer's reached this conclusion for some of their cruft.

My conclusion from reading this thread is that a proposal for hybrid files 
should demonstrate a significant win over the work of w3.org before such a 
radical semantic alteration is made. I hope
the comments of a humble and grateful user can be of some use and please 
accept my apology
if I have mis-understood this discussion or squandered your time.

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
hthttp://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

