Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVIMRVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVIMRVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbVIMRVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:21:22 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:59654 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964905AbVIMRVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:21:21 -0400
Date: Tue, 13 Sep 2005 18:21:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Joe Bob Spamtest <joebob@spamtest.viacore.net>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
In-Reply-To: <20050913165228.GG28578@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61L.0509131819140.4219@blysk.ds.pg.gda.pl>
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net>
 <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net>
 <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Lennart Sorensen wrote:

> Of course mips is extra fun in having two 32bit formats and one 64bit
> format.

 The reverse -- two 64-bit formats and one 32-bit one.  And don't forget 
to multiply by two endiannesses. ;-)

  Maciej
