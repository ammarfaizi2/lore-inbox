Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSHXSQs>; Sat, 24 Aug 2002 14:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSHXSQs>; Sat, 24 Aug 2002 14:16:48 -0400
Received: from p50887F28.dip.t-dialin.net ([80.136.127.40]:13989 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316615AbSHXSQs>; Sat, 24 Aug 2002 14:16:48 -0400
Date: Sat, 24 Aug 2002 12:20:46 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: Arador <diegocg@teleline.es>, <dag@newtech.fi>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <conman@kolivas.net>
Subject: Re: Preempt note in the logs
In-Reply-To: <1030212663.861.3.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208241219150.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hmmm... If we run a program that does neither read nor write, can the 
library opens still trigger the preempt_count++ if it's really the r/w 
code to blaim?

Oh no, it's raining in again!

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

