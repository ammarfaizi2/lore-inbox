Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289514AbSAOM1V>; Tue, 15 Jan 2002 07:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289517AbSAOM1L>; Tue, 15 Jan 2002 07:27:11 -0500
Received: from [195.66.192.167] ([195.66.192.167]:49926 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289514AbSAOM05>; Tue, 15 Jan 2002 07:26:57 -0500
Message-Id: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG] cs46xx: sound distortion after hours of use
Date: Tue, 15 Jan 2002 14:24:00 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that after hours of palying mp3s thru my onboard audio
(I use cs46xx module) sound becomes distorted (high-pitch noise).

Restarting xmms does not help.

rmmod cs46xx; modprobe cs46xx fixes it.
--
vda
