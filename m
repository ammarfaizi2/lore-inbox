Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268953AbTBSQTx>; Wed, 19 Feb 2003 11:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268956AbTBSQTs>; Wed, 19 Feb 2003 11:19:48 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:7065 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S268953AbTBSQTf> convert rfc822-to-8bit;
	Wed, 19 Feb 2003 11:19:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.4.20 amd speculative caching
Date: Wed, 19 Feb 2003 10:28:41 -0600
Message-ID: <A5D66E6B6F478B48A3CEF22AA4B9FCA3012E54@umr-mail1.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.20 amd speculative caching
Thread-Index: AcLYM/YPfVqwUCCtSvuXTRcXKqgNdA==
From: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
To: <linux-kernel@vger.kernel.org>
Cc: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently upgraded to an AMD processor that is exhibiting the
problems with the AMD speculative caching bug. Kernel 2.4.19 seems to
fix the problem with the temporary work-around (adv-spec-cache patch). I
have noticed that the patch has been removed from 2.4.20 and I am
wondering if there is some other mechanism that is supposed to address
this issue. Currently I have a  2.4.20 kernel with same configuration as
my 2.4.19 and the problem seems to have reappeared.
			Thanks for any information.
				(please CC my address on reply) 
				Craig Sowadski (sowadski@umr.edu)
 
