Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSEKCV0>; Fri, 10 May 2002 22:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316193AbSEKCVZ>; Fri, 10 May 2002 22:21:25 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:35469 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316192AbSEKCVZ>; Fri, 10 May 2002 22:21:25 -0400
Date: Fri, 10 May 2002 21:21:16 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget-locked [2/6] 
In-Reply-To: <2149.1021076559@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0205102120210.11642-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Keith Owens wrote:

> Build time is the least of your worries here.  All objects that export
> symbols must have unique basenames, all the modversion crud goes in
> include/linux/modules under the object's basename.

This is not true anymore in 2.5, this limitation was removed when ALSA 
went in.

--Kai

