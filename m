Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319228AbSH2PZ0>; Thu, 29 Aug 2002 11:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319232AbSH2PZ0>; Thu, 29 Aug 2002 11:25:26 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:55803
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319228AbSH2PZZ>; Thu, 29 Aug 2002 11:25:25 -0400
Subject: Re: 2.4.20-pre4-ac1 trashed my system
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Isely <isely@pobox.com>, andre@linux-ide.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208290900130.10104-100000@grace.speakeasy.net>
References: <Pine.LNX.4.44.0208290900130.10104-100000@grace.speakeasy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 16:32:05 +0100
Message-Id: <1030635125.7190.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The promise 20265 does need special handling for LBA48 I believe. The
code should also be handling it correctly. Cc'd to Andre to investigate
further

