Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTFTOOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTFTOOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:14:51 -0400
Received: from 211.187-201-80.adsl.skynet.be ([80.201.187.211]:59661 "EHLO
	obelix.village-gaulois") by vger.kernel.org with ESMTP
	id S262259AbTFTOOu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:14:50 -0400
Subject: Re: xircom card bus with 2.4.20 link trouble
From: Arnaud Ligot <spyroux@freegates.be>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0306201007470.15589-100000@router.windsormachine.com>
References: <Pine.LNX.4.33.0306201007470.15589-100000@router.windsormachine.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1056119306.6727.27.camel@portable>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Jun 2003 16:28:27 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 20/06/2003 à 16:11, Mike Dresser a écrit :
>> bla bla bla...
> 
> Mine doesn't work either, I have a RBEM56G-100.
> 
> Bought this off ebay for quite cheap to replace my REM56G-100.
> 
> It detects it, etc etc, but never actually works.
> 
> I put the REM56G-100 back in, insmod'd the driver, and back in business.
> 
I have a CEM56-100

> I haven't tried a 2.5.x kernel, nor a 2.4.21(it's on my list of things to
> do)
the card works with 2.4.20 nice and works if you set an ip address with
the 2.4.21

> I was using the xircom_cb driver though.  The xircom_tulip_cb didn't work
> either.
I use the xirc2ps_cs module. I haven't force cardmgr to use so I think
it's the good module for the card

-- 
Arnaud Ligot <spyroux@freegates.be>

