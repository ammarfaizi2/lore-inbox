Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbTC1JT0>; Fri, 28 Mar 2003 04:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262846AbTC1JT0>; Fri, 28 Mar 2003 04:19:26 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:27499 "EHLO
	exchange.Pronto.TV") by vger.kernel.org with ESMTP
	id <S262845AbTC1JTZ> convert rfc822-to-8bit; Fri, 28 Mar 2003 04:19:25 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: turning off kernel dhcp klient on _one_ nic?
Date: Fri, 28 Mar 2003 10:30:35 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303281030.35551.roy@karlsbakk.net>
X-OriginalArrivalTime: 28 Mar 2003 09:32:24.0968 (UTC) FILETIME=[F0E3F880:01C2F50C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

is it possible to turn off the kernel dhcp client / kernel autoconfiguration 
on _one_ nic? We're using dual gigabit cards from intel (e1000), so splitting 
up modular/static drivers obviously won't do the job. I've search through the 
kernel doc, but I can't find anything...

best regards

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

