Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbSKDCKa>; Sun, 3 Nov 2002 21:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSKDCKX>; Sun, 3 Nov 2002 21:10:23 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10175 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264620AbSKDCKW>;
	Sun, 3 Nov 2002 21:10:22 -0500
Date: Sun, 3 Nov 2002 18:12:33 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oh no, local symbols in discarded section .exit.text _again_ :)
In-Reply-To: <200211031139.gA3Bdtp27867@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L2.0211031810010.10796-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Denis Vlasenko wrote:

| I've got well-known
|
| drivers/built-in.o(.data+0xa6b4): undefined reference to
| `local symbols in discarded section .exit.text'
|
| There was some tool (by Keith Owens AFAIK) to find in which *.c
| did that happen, can somebody point me to it?
| --

I'm sure that you can find it, but I'll bet money that it's
in my "scripts" collection since I save almost every usable
kernel-related script that I see.

I'd like to see kernelnewbies.org or some place collect
and list such scripts so that everyone can find them easily.

-- 
~Randy

