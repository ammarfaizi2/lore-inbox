Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbREZXfp>; Sat, 26 May 2001 19:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbREZXff>; Sat, 26 May 2001 19:35:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:2058 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262573AbREZXf2>; Sat, 26 May 2001 19:35:28 -0400
Subject: Re: [2.4.5] buz.c won't compile
To: sembera@centrum.cz (Jan Sembera)
Date: Sun, 27 May 2001 00:32:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B0FEB1B.5030308@centrum.cz> from "Jan Sembera" at May 26, 2001 04:42:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153nY0-0008LU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i've got a problem compiling drivers/media/video/buz.c as module. When 
> i'm trying to compile, i get couple of errors:

If you need buz support you need -ac
