Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282481AbRLFScl>; Thu, 6 Dec 2001 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbRLFScc>; Thu, 6 Dec 2001 13:32:32 -0500
Received: from pD9001D7D.dip.t-dialin.net ([217.0.29.125]:24068 "EHLO
	maxwell.hgf.local") by vger.kernel.org with ESMTP
	id <S282481AbRLFScQ> convert rfc822-to-8bit; Thu, 6 Dec 2001 13:32:16 -0500
Date: Thu, 6 Dec 2001 19:30:54 +0100 (CET)
From: Hans-Georg Fischer <hgf@snafu.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange problem with 2.4.x kernel
In-Reply-To: <20011206190454.B848@cheetah.chello.pl>
Message-ID: <Pine.LNX.4.10.10112061923350.1568-100000@maxwell.hgf.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, [iso-8859-2] Mateusz £oskot wrote:

> invalid compressed data: CRC-ERROR

Did you compare the size of the downloaded kernels with the originals
on the ftp-server. Are they identical to the byte? This answers the
question if your ftp-program really used binary mode.
I once encountered a ftp-program which pretended using binary mode but
did not. 

--
Hans-Georg



