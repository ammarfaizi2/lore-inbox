Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262347AbREUU0Q>; Mon, 21 May 2001 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262345AbREUU0H>; Mon, 21 May 2001 16:26:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5640 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262269AbREUUZy>; Mon, 21 May 2001 16:25:54 -0400
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 21 May 2001 21:20:35 +0100 (BST)
Cc: rgooch@ras.ucalgary.ca (Richard Gooch), viro@math.psu.edu (Alexander Viro),
        matthew@wil.cx (Matthew Wilcox), alan@lxorguk.ukuu.org.uk (Alan Cox),
        clausen@gnu.org (Andrew Clausen), bcrl@redhat.com (Ben LaHaise),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20010520231330.E2647@bug.ucw.cz> from "Pavel Machek" at May 20, 2001 11:13:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151wAN-0000pE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't need to read it. Don't be insulting. Sure, you *can* use a
> > write(2)/read(2) cycle. But that's two syscalls compared to one with
> > ioctl(2) or transaction(2). That can matter to some applications.
> 
> I just don't think so. Where did you see performance-critical use of
> ioctl()?

AGP, video4linux,...

Alan

