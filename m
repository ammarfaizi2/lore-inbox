Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131979AbRDFQRz>; Fri, 6 Apr 2001 12:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDFQRp>; Fri, 6 Apr 2001 12:17:45 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:49163 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S131942AbRDFQRk>; Fri, 6 Apr 2001 12:17:40 -0400
From: Norbert Preining <preining@logic.at>
Date: Fri, 6 Apr 2001 18:16:49 +0200
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc oopses with 2.4.3
Message-ID: <20010406181649.A20430@alpha.logic.tuwien.ac.at>
In-Reply-To: <20010406174442.A19874@alpha.logic.tuwien.ac.at> <123100000.986572812@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <123100000.986572812@tiny>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fre, 06 Apr 2001, Chris Mason wrote:
> Neat, looks like you've installed the all new extreiser2fs.  Really though,
> do you have ext2 on the box at all?

Sounds great, yeah. No I have
/tmp 	ext2
/boot	ext2
rest	reiserfs

> sigbus from gcc usually points to the ram, have you run a tester?

memtest2.5 for about 2 hours running, no error, 550MHz CPU, 128Mb RAM.

Best wishes

Norbert

-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
