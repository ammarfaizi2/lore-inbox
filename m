Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSHBLsO>; Fri, 2 Aug 2002 07:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318795AbSHBLsO>; Fri, 2 Aug 2002 07:48:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:28662 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318793AbSHBLsO>; Fri, 2 Aug 2002 07:48:14 -0400
Subject: Re: IDE from current bk tree, UDMA and two channels...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Alexander Viro <viro@math.psu.edu>, martin@dalecki.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <CF6774723C@vcnet.vc.cvut.cz>
References: <CF6774723C@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 14:07:57 +0100
Message-Id: <1028293677.18309.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 00:13, Petr Vandrovec wrote:
> Last half-KB is useless, as filesystem on it is ext2 with 4KB blocks... 
> Only problem is that previously stable system was now dying in e2fsck. I'll 
> try to invent some solution before 2.6 ;-) 

Guess where EFI puts partition tables 8(

