Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269068AbTBXBqa>; Sun, 23 Feb 2003 20:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269070AbTBXBqa>; Sun, 23 Feb 2003 20:46:30 -0500
Received: from palrel10.hp.com ([156.153.255.245]:28352 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id <S269068AbTBXBq1>;
	Sun, 23 Feb 2003 20:46:27 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15961.31702.478219.82652@napali.hpl.hp.com>
Date: Sun, 23 Feb 2003 17:56:38 -0800
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: davidm@hpl.hp.com, David Lang <david.lang@digitalinsight.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <Pine.LNX.4.53.0302231704310.23231@twinlark.arctic.org>
References: <15961.19948.882374.766245@napali.hpl.hp.com>
	<Pine.LNX.4.44.0302231444490.8609-100000@dlang.diginsite.com>
	<15961.20756.474745.44896@napali.hpl.hp.com>
	<Pine.LNX.4.53.0302231704310.23231@twinlark.arctic.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 23 Feb 2003 17:06:29 -0800 (PST), dean gaudet <dean-list-linux-kernel@arctic.org> said:

  Dean> On Sun, 23 Feb 2003, David Mosberger wrote:
  >> >>>>> On Sun, 23 Feb 2003 14:48:48 -0800 (PST), David Lang <david.lang@digitalinsight.com> said:

  David.L> I would call a 15% lead over the ia64 pretty substantial.

  >> Huh?  Did you misread my mail?

  >> 2 GHz Xeon:		701 SPECint
  >> 1 GHz Itanium 2:	810 SPECint

  >> That is, Itanium 2 is 15% faster.

  Dean> according to pricewatch i could buy ten 2GHz Xeons for about
  Dean> the cost of one Itanium 2 900MHz.

Not if you want comparable cache-sizes [1]:

 Intel Xeon MP, 2MB L3 cache:		$3692

 Itanium 2, 1 GHZ, 3MB L3 cache:	$4226
 Itanium 2, 1 GHZ, 1.5MB L3 cache:	$2247
 Itanium 2, 900 MHZ, 1.5MB L3 cache:	$1338

Intel basically prices things by the cache size.

	--david

[1]: http://www.intel.com/intel/finance/pricelist/
