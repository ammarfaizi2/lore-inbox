Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSIBExc>; Mon, 2 Sep 2002 00:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSIBExc>; Mon, 2 Sep 2002 00:53:32 -0400
Received: from pD9E237CF.dip.t-dialin.net ([217.226.55.207]:45284 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318227AbSIBExb>; Mon, 2 Sep 2002 00:53:31 -0400
Date: Sun, 1 Sep 2002 22:57:59 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: dirty boy <slashdotcommacolon@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux ELF Implementation
In-Reply-To: <20020902060749.A6109@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.44.0209012256500.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2 Sep 2002, Ralf Baechle wrote:
> There answer is no; the ELF magic at the begin of an ELF file contains
> a non-printable character.

...and yes if you write a program which concatenates half-based characters 
to a full base, the only thing that hurts is that you have to write at 
least twice as much...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

