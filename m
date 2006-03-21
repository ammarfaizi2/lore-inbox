Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWCUR2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWCUR2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCUR2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:28:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35286 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751418AbWCUR2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:28:09 -0500
Date: Tue, 21 Mar 2006 18:28:04 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix console utf8 composing (F)
In-Reply-To: <20060321001940.098331ad@werewolf.auna.net>
Message-ID: <Pine.LNX.4.61.0603211823120.21376@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
 <20060321001940.098331ad@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1042484623-1142962084=:21376"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1042484623-1142962084=:21376
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>+1
>Whith this I can type accented chars in console.

>Just a note. Is this also needed ?
>http://marc.theaimsgroup.com/?l=linux-kernel&m=114104232611272&w=2

Note that our (my and Alexander's try) at the utf8 patch only affects 
composing. If you have a "native" umlaut key or whatever, it will work 
without the patch.

I am not sure if you need Adam Tlałka's patch too.
At least you do not need it for composing, and I have not found any 
annoyance in my regular day that would require me to assume another bug
in the utf8 code.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
--1283855629-1042484623-1142962084=:21376--
