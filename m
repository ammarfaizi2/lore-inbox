Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133083AbREERfz>; Sat, 5 May 2001 13:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133105AbREERfp>; Sat, 5 May 2001 13:35:45 -0400
Received: from cabal.darkness.net ([204.56.57.2]:51751 "EHLO
	cabal.darkness.net") by vger.kernel.org with ESMTP
	id <S133083AbREERfb>; Sat, 5 May 2001 13:35:31 -0400
Date: Sat, 5 May 2001 11:34:58 -0600
From: Jeremy <heffner@darkness.net>
To: Seth Goldberg <bergsoft@home.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Message-ID: <20010505113458.A14468@bletchley.darkness.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick note.  I *AM* seeing this problem on a Tyan S2390B which has the
Via KT133A chipset on it.

AMD Athlon 1.33ghz
2x256m DIMMs
Linux 2.4.4-ac5

I haven't done the ksymoops conversions yet, but please let me know if you'd
like anything else.  But basically, it looks exactly like what all the IWILL
owners are seeing.

Any other tyan S2390B users?

thx, -j


-- 
---------------------------------------------------------------------------
                          heffner at darkness.net
                       Darkness Network Engineering
                   PGP public key available on request
            My thoughts and opinions represent no one but myself
---------------------------------------------------------------------------
