Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267089AbSLKJjH>; Wed, 11 Dec 2002 04:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSLKJjH>; Wed, 11 Dec 2002 04:39:07 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:65250 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267089AbSLKJjF>; Wed, 11 Dec 2002 04:39:05 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: CD Writing in 2.5.51
References: <1039598049.480.7.camel@nirvana> <87fzt43nm4.fsf@web.de>
	<1039599708.711.9.camel@nirvana>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Wed, 11 Dec 2002 10:46:11 +0100
In-Reply-To: <1039599708.711.9.camel@nirvana> (mdew's message of "11 Dec
 2002 22:41:45 +1300")
Message-ID: <87adjc3n30.fsf@web.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* mdew  writes:
>On Wed, 2002-12-11 at 22:34, Markus Plail wrote:
>>You don't need any additional modules. Just don't activate ide-scsi by
>>either not appending ide-scsi/scsi=hdX or not compiling ide-scsi
>>support in the kernel.
>can i completely remove scsi support then? (I dont have any scsi device)

Yes.

regards
Markus

