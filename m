Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271718AbRHUP2l>; Tue, 21 Aug 2001 11:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271719AbRHUP2V>; Tue, 21 Aug 2001 11:28:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59922 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271718AbRHUP2M>; Tue, 21 Aug 2001 11:28:12 -0400
Subject: Re: Qlogic/FC firmware
To: riel@conectiva.com.br (Rik van Riel)
Date: Tue, 21 Aug 2001 16:30:46 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), alan@lxorguk.ukuu.org.uk,
        jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108211141030.5646-100000@imladris.rielhome.conectiva> from "Rik van Riel" at Aug 21, 2001 11:42:11 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZDUM-00086s-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess using an initrd on these 0.3% of machines shouldn't
> be too big a problem compared to violating the GPL and adding
> to kernel bloat for everybody else.

The license thing is a side issue. We have a sane relationship with Qlogic
so that can easily be dealt with. For 2.5 it definitely wants to be in
initrd-tng however
