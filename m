Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSEaBCp>; Thu, 30 May 2002 21:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSEaBCo>; Thu, 30 May 2002 21:02:44 -0400
Received: from [64.76.155.18] ([64.76.155.18]:31439 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S313537AbSEaBCo>;
	Thu, 30 May 2002 21:02:44 -0400
Date: Thu, 30 May 2002 20:57:08 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre9-ac3
In-Reply-To: <200205310040.g4V0eZb25262@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0205302052060.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Alan Cox wrote:

> It escaped 8)
> 

You also forgot to change the EXTRAVERSION in the top Makefile 8)

diff -u linux/Makefile linux-ac/Makefile
--- linux/Makefile	Thu May 30 20:16:59 2002
+++ linux-ac/Makefile	Thu May 30 21:03:57 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 19
-EXTRAVERSION = -pre9-ac2
+EXTRAVERSION = -pre9-ac3

Best regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

