Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbTBHMG6>; Sat, 8 Feb 2003 07:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTBHMG6>; Sat, 8 Feb 2003 07:06:58 -0500
Received: from host-80-252-0-105.gazeta.pl ([80.252.0.105]:3461 "EHLO
	virgin.gazeta.pl") by vger.kernel.org with ESMTP id <S266989AbTBHMG6>;
	Sat, 8 Feb 2003 07:06:58 -0500
Date: Sat, 8 Feb 2003 13:16:33 +0100
From: =?iso-8859-2?Q?Przemys=B3aw?= Maciuszko <sal@agora.pl>
To: linux-kernel@vger.kernel.org
Subject: Problem with mm in 2.4.19 and 2.4.20
Message-ID: <20030208121633.GB17017@virgin.gazeta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I have a problem with one news server (feeder) box running INN.
Under heavy load i get the following error on the console:

filemap.c:2084: bad pmd 2bc001e3

This showed few times during last few days and few times server 'hanged up'
after this.
Anyone has an idea what can cause it?

I'm using Linux Debian on dual PIII 1.1Ghz, 1GB RAM, LVM version 1.0.6,
Qlogic FC 2200F driver version 6.01
Any help would be apreciated...


-- 
Przemys³aw Maciuszko
Agora S.A.
