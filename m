Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRLQNYI>; Mon, 17 Dec 2001 08:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRLQNX7>; Mon, 17 Dec 2001 08:23:59 -0500
Received: from coruscant.franken.de ([193.174.159.226]:15075 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S277294AbRLQNXj>; Mon, 17 Dec 2001 08:23:39 -0500
Date: Mon, 17 Dec 2001 13:54:36 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Edward Killips" <etkillips@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfilter Oops Solved
Message-ID: <20011217135436.S32507@sunbeam.de.gnumonks.org>
In-Reply-To: <F141o1ujjSkZSvx5bd600005006@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <F141o1ujjSkZSvx5bd600005006@hotmail.com>; from etkillips@hotmail.com on Mon, Dec 17, 2001 at 01:07:52AM -0500
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.14
X-Date: Today is Boomtime, the 55th day of The Aftermath in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 01:07:52AM -0500, Edward Killips wrote:
> I found the problem in the netfilter code. In the file ipt_TOS.c the 
> following code is wrong;

Thanks for pointing out this issue.  According to DaveM, this fix has already
been submitted to Marcelo for Kernel inclusion.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
