Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283604AbRK3K5e>; Fri, 30 Nov 2001 05:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283601AbRK3K5Z>; Fri, 30 Nov 2001 05:57:25 -0500
Received: from coruscant.franken.de ([193.174.159.226]:21409 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S283599AbRK3K5K>; Fri, 30 Nov 2001 05:57:10 -0500
Date: Fri, 30 Nov 2001 11:53:06 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>
Cc: Martin Josefsson <gandalf@marcelothewonderpenguin.com>,
        linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
Subject: [RESOLVED] [BUG] vanilla 2.4.15 iptables/REDIRECT kernel oops
Message-ID: <20011130115306.A1684@naboo.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Rolf Fokkens <fokkensr@linux06.vertis.nl>,
	Martin Josefsson <gandalf@marcelothewonderpenguin.com>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.samba.org
In-Reply-To: <Pine.LNX.4.21.0111271600420.23169-100000@tux.rsn.bth.se> <01112723555300.01996@home01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <01112723555300.01996@home01>; from fokkensr@linux06.vertis.nl on Tue, Nov 27, 2001 at 11:55:53PM -0800
X-Operating-System: Linux naboo.gnumonks.org 2.4.15-pre2-ben0
X-Date: Today is Prickle-Prickle, the 42nd day of The Aftermath in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 11:55:53PM -0800, Rolf Fokkens wrote:
> OK. So there hasn't been much response for this BUG report. So I did a little 
> investigating myself.

The bug was just known in 2.4.15-pre series, but not in the final 2.4.15.

Anyway, 2.4.16 is certainly (we just confirmed that by testing) not affected by
this bug, since the problematic patch has been pulled out again.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
