Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316498AbSEUDlR>; Mon, 20 May 2002 23:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSEUDlQ>; Mon, 20 May 2002 23:41:16 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:9742 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316498AbSEUDlQ>; Mon, 20 May 2002 23:41:16 -0400
Message-Id: <200205210338.g4L3cn947655@aslan.scsiguy.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: Allow aic7xx firmware to be built from BK tree. 
In-Reply-To: Your message of "Tue, 21 May 2002 11:19:36 +1000."
             <15593.41128.652928.573561@wombat.chubb.wattle.id.au> 
Date: Mon, 20 May 2002 21:38:49 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>This patch removes the two generate files (that are also in the
>distributed kernel) before attempting to regenerate them.

Why is this necessary?

>The real question is, why are there generated files distributed with
>the kernel source?

Because, as I found out when I first contributed this driver,
not everyone has the tools necessary to build the assembler required
to generate these files.

--
Justin
