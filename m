Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291021AbSBLNeb>; Tue, 12 Feb 2002 08:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291026AbSBLNeV>; Tue, 12 Feb 2002 08:34:21 -0500
Received: from mustard.heime.net ([194.234.65.222]:64697 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S291021AbSBLNeF>; Tue, 12 Feb 2002 08:34:05 -0500
Date: Tue, 12 Feb 2002 14:33:47 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: secure erasure of files?
In-Reply-To: <200202121326.g1CDQct12086@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.30.0202121431560.18694-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO overwriting with /dev/zero or /dev/random is sufficient.
> Recovering data after that falls into urban legend category :-)

I know of personal experience that the company ibas (http://www.ibas.com)
have, in lab, recovered data overwritten >30 times. To recover data
overwritten from /dev/zero is done in minutes.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


