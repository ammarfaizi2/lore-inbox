Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUCWWmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbUCWWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:42:45 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:29138 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262899AbUCWWmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:42:44 -0500
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: Thinkpad 560X w/ 160MB memory (2.4.24 kernel): many segfaults 
In-Reply-To: Your message of "Tue, 23 Mar 2004 08:47:05 +0200."
             <200403230847.05533.vda@port.imtp.ilyichevsk.odessa.ua> 
Date: Tue, 23 Mar 2004 22:42:40 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1B5ubY-0003Om-00@coll.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> burnBX (from cpuburn) could detect the problem within 8 seconds.
> [or burnMMX]

Thanks for these suggestions.  I ran each for several minutes and got
no errors.  So I'm still puzzled, but maybe it is a subtle memory
incompatability that neither program detects (yet somehow Linux works
the machine so hard and uncovers it?).

-Sanjoy
