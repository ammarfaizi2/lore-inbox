Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270330AbRHMRo0>; Mon, 13 Aug 2001 13:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270328AbRHMRoR>; Mon, 13 Aug 2001 13:44:17 -0400
Received: from alto.i-cable.com ([210.80.60.4]:60666 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S270330AbRHMRoH>;
	Mon, 13 Aug 2001 13:44:07 -0400
Date: Tue, 14 Aug 2001 01:44:23 +0800 (HKT)
From: lkthomas@hkicable.com
Message-Id: <200108131744.BAA27539@alto.i-cable.com>
To: linux-kernel@vger.kernel.org
Subject: memory compress tech...
X-Mailer: Gmail 0.7.0 (http://gmail.linuxpower.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another suggestion, mate
if you are using dos before, you must know a tools call "QEMM" 
http://www.netten.net/~garycox/qemm3.htm
you can look over this URL if you do not know what is that
it can do a real time memory compress and decompress tools ( I mean on fly ), the sound like IBM of MXT..
so people can use more memory as they want
but IBM one can not compile into kernel :(
so I am thinking if someone can program a new code into kernel and let user to select if use it or not
( 8M data in RAM can compress to 4-5M, so people can free up more to use in another side )
I hope this one would help for end user :)
Thanks

