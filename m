Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281772AbRLFSEy>; Thu, 6 Dec 2001 13:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281779AbRLFSEr>; Thu, 6 Dec 2001 13:04:47 -0500
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:9397 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S281772AbRLFSEe>; Thu, 6 Dec 2001 13:04:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, stoffel@casc.com (John Stoffel)
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Date: Thu, 6 Dec 2001 05:03:12 -0500
X-Mailer: KMail [version 1.3.1]
Cc: riel@conectiva.com.br (Rik van Riel), esr@thyrsus.com (Eric S. Raymond),
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <E16C2HM-0002JR-00@the-village.bc.nu>
In-Reply-To: <E16C2HM-0002JR-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206180432.IHMU19462.femail37.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 December 2001 12:25 pm, Alan Cox wrote:
> > So has anyone had time to test the Python version 1.5 based CML2 that
> > was posted?  Would that make it more acceptable?
>
> For 2.5 its a great leap forward. For 2.4 its irrelevant. Its simply not
> the way stable kernel trees are run, even for people who think they are
> above the rules and traditions

Ooh, I can't resist...

"You mean like Linus?"

(Ducks, runs, looks innocent, runs some more...)

Rob

P.S.  Can we seperate "add new subsystem y prime" and "remove old subsystem 
y".  LIke the new and old SCSI error handling, which have been in the tree in 
parallel for some time?  Did I hear Eric ever suggest removing the old 
configurator for 2.4?  Anybody?
