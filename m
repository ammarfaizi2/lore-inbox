Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTLJOOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTLJOOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:14:10 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:50639 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262355AbTLJOOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:14:08 -0500
Message-Id: <200312101413.hBAEDYTi000734@ginger.cmf.nrl.navy.mil>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net
Subject: Re: [Linux-ATM-General] Re: 2.4.22 with CONFIG_M686: networking broken 
In-Reply-To: Message from Peter Daum <gator@cs.tu-berlin.de> 
   of "Tue, 09 Dec 2003 23:47:18 +0100." <Pine.LNX.4.30.0312092344360.17719-100000@swamp.bayern.net> 
Date: Wed, 10 Dec 2003 09:13:35 -0500
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0312092344360.17719-100000@swamp.bayern.net>,Peter Da
um writes:
>... the same bug is still present in kernel version 2.4.23.
>As I know meanwhile, it only occurs on ATM/LANE network connections.

which atm card are you using?  if you are using a he155/622 then i am
probably setting the cacheline size wrong.

