Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbRE3Sig>; Wed, 30 May 2001 14:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbRE3Si0>; Wed, 30 May 2001 14:38:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55558 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261812AbRE3SiW>; Wed, 30 May 2001 14:38:22 -0400
Subject: Re: [PATCH] 245-ac4
To: carlos@techlinux.com.br (Carlos E Gorges)
Date: Wed, 30 May 2001 19:35:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01053015181600.08588@shark.techlinux> from "Carlos E Gorges" at May 30, 2001 03:18:16 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155AoN-0006Nb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch remove some NULL parameters tests in kfree-like functions an=
> d add this directly in function.

Please dont do this, it just makes it harder to follow the tests and the code
logic
