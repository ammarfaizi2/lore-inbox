Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281382AbRKTUeI>; Tue, 20 Nov 2001 15:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281403AbRKTUd7>; Tue, 20 Nov 2001 15:33:59 -0500
Received: from serv02.lahn.de ([195.211.46.202]:8237 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S281382AbRKTUdu>;
	Tue, 20 Nov 2001 15:33:50 -0500
X-Spam-Filter: check_local@serv02.lahn.de by digitalanswers.org
Date: Tue, 20 Nov 2001 21:21:27 +0100 (CET)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: pmhahn@titan.lahn.de
To: Mark Hymers <markh@linuxfromscratch.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MODULE_LICENSE tags for nls
In-Reply-To: <20011119193909.B878@markcomp.blaydon.hymers.org.uk>
Message-ID: <Pine.LNX.4.40.0111202119200.22656-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Mark Hymers wrote:

> nls_big5.c, nls_cp932.c, nls_cp936.c, nls_cp949.c, nls_cp950.c,
> nls_euc-jp.c, nls_euc-kr.c, nls_gb2312.c, nls_iso8859-1.c,
> nls_iso8859-13.c, nls_iso8859-14.c, nls_iso8859-15.c, nls_iso8859-2.c,
> nls_iso8859-3.c, nls_iso8859-4.c, nls_iso8859-5.c, nls_iso8859-6.c,
> nls_iso8859-7.c, nls_iso8859-8.c, nls_iso8859-9.c, nls_koi8-r.c,
> nls_koi8-ru.c, nls_koi8-u.c, nls_sjis.c, nls_tis-620.c, nls_utf8.c
>
> All of the other nls files are described with the line:
> MODULE_LICENSE("BSD without advertising clause");

All occurences of "BSD without advertising clause" were substituted with
"Dual BSD/GPL". You might try it again with that one. Grep
patch-2.4.15-pre7 for an example or search the archive for the discussion.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

