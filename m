Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSAXL2o>; Thu, 24 Jan 2002 06:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSAXL2e>; Thu, 24 Jan 2002 06:28:34 -0500
Received: from [195.66.192.167] ([195.66.192.167]:50449 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287487AbSAXL2c>; Thu, 24 Jan 2002 06:28:32 -0500
Message-Id: <200201241127.g0OBR6E10381@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
Date: Thu, 24 Jan 2002 13:27:08 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua> <3C449426.6000300@us.ibm.com> <20020117010420.B31976@chiark.greenend.org.uk>
In-Reply-To: <20020117010420.B31976@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > BTW, I have a Thinkpad T21.  Do any of you have a non-IBM notebook?
>
> I have a non-IBM non-notebook apparently with this problem. It's an Athlon
> XP/Via KT266A desktop system with a Turtle Beach Santa Cruz soundcard,
> running kernel 2.4.17 with cs46xx as a module and APM compiled in. Sound
> became very distorted playing MP3s, rmmod cs46xx followed by modprobe
> cs46xx fixed the problem. It's only happened once so far, but I've only had
> this machine for two weeks.
>
> I'm afraid cat /proc/apm doesn't seem to reproduce the problem for me
> either.

Just happened here again. I pressed pause in XMMS, then pressed it again to 
unpause, now sound is mixed with high-pitched noise
--
vda
