Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313179AbSEEQxq>; Sun, 5 May 2002 12:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313184AbSEEQxp>; Sun, 5 May 2002 12:53:45 -0400
Received: from moutng0.kundenserver.de ([212.227.126.170]:62406 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S313179AbSEEQxp> convert rfc822-to-8bit; Sun, 5 May 2002 12:53:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Fabian Svara <svara@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:82
Date: Sun, 5 May 2002 18:53:38 +0200
X-Mailer: KMail [version 1.4]
In-Reply-To: <20020505204046.7a374220.svara@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200205051853.38557.linux-kernel@borntraeger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Svara wrote:
> EIP:	0010:[<c0125183>]    Tainted: P

You have the Binary-NVIDIA Driver loaded, haven't you?
If yes, please report this bug to Nvidia, since nobody here can help you 
because the main part of the driver is closed source and nobody knows, what 
the driver is doing with the memory.

Christian

