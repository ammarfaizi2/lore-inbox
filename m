Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSEXOX6>; Fri, 24 May 2002 10:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316874AbSEXOX5>; Fri, 24 May 2002 10:23:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51979 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314433AbSEXOX4>; Fri, 24 May 2002 10:23:56 -0400
Subject: Re: 2.2.x and DRM Modules / AGPgart
To: mcp@linux-systeme.de (Marc-Christian Petersen)
Date: Fri, 24 May 2002 15:24:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205240255.21249.mcp@linux-systeme.de> from "Marc-Christian Petersen" at May 24, 2002 03:01:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BFzt-0006Ht-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> again this question to the 2.2. Kernel tree, why this kernels does not have 
> the new DRM Engine? Its out since January 2002.

Linux 2.2 is backward compatible with Linux 2.2 stuff. That means the old
DRM will be staying in 2.2
