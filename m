Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274035AbRJBNtt>; Tue, 2 Oct 2001 09:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274041AbRJBNtj>; Tue, 2 Oct 2001 09:49:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9735 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274035AbRJBNt2>; Tue, 2 Oct 2001 09:49:28 -0400
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Tue, 2 Oct 2001 14:49:10 +0100 (BST)
Cc: matt@theBachChoir.org.uk (Matt Bernstein),
        hpa@transmeta.com (H. Peter Anvin), alan@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <15289.44299.915454.3729@charged.uio.no> from "Trond Myklebust" at Oct 02, 2001 02:03:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oPv4-0004gl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what I can see, Alan merged that particular patch into 2.4.9-ac11 (but
> without merging in the related changes to linux/mm/filemap.c).

Ok its probably better I merge the related mm/filemap.c changes if someone
has the relevant bits handy. That helps to keep the differences down
