Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVKTAm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVKTAm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 19:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKTAm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 19:42:56 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:44612 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750814AbVKTAmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 19:42:55 -0500
Date: Sun, 20 Nov 2005 00:42:52 +0000 (GMT)
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: =?ISO-8859-1?Q?St=E9phane_BAUSSON?= <stephane.bausson@free.fr>
cc: Ken Moffat <zarniwhoop@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: Fail to buil linux-2.6.14
In-Reply-To: <437FAFD4.7020304@free.fr>
Message-ID: <Pine.LNX.4.63.0511200042050.16769@deepthought.mydomain>
References: <437CF690.5060206@free.fr> <Pine.LNX.4.63.0511172335570.15546@deepthought.mydomain>
 <437FAFD4.7020304@free.fr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1010228490-1132447372=:16769"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1010228490-1132447372=:16769
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 19 Nov 2005, Stéphane BAUSSON wrote:

> I fixed it by increasing the the 0x400 offset in 
> arch/i386/kernel/vsyscall.lds to 0xb00 ...
> I do not understand why this issue is specific to my config.
>

  Me neither.  Just out of interest, which version of glibc are you 
using ?

Ken
-- 
  das eine Mal als Tragödie, das andere Mal als Farce

---1463809536-1010228490-1132447372=:16769--
