Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132563AbRDOBQd>; Sat, 14 Apr 2001 21:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbRDOBQO>; Sat, 14 Apr 2001 21:16:14 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:42800 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S132563AbRDOBQE>; Sat, 14 Apr 2001 21:16:04 -0400
Date: Sun, 15 Apr 2001 03:16:01 +0200
From: Marc SCHAEFER <schaefer@alphanet.ch>
Message-Id: <200104150116.DAA30668@vulcan.alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI tape corruption problem
Newsgroups: alphanet.ml.linux.kernel
In-Reply-To: <Pine.LNX.4.31.0104142124390.1307-100000@eris.discordia.loc>
Organization: ALPHANET NF -- Not for profit telecom research
X-Newsreader: TIN [UNIX 1.3 unoff BETA 970705; i586 Linux 2.0.38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0104142124390.1307-100000@eris.discordia.loc> you wrote:
> ... still, I've investigated on this because amverify gave me a ton of
> crc errors... (I REALLY hope that amanda uses proper blocking :)

yes, it does.

This really looks like a st problem, or kernel. Or host adapter, or :)

I have to try 2.4.x soon. Problem is for me 2.2.x is enough :)
