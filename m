Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277727AbRJLPMd>; Fri, 12 Oct 2001 11:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277725AbRJLPMZ>; Fri, 12 Oct 2001 11:12:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3086 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277727AbRJLPMJ>; Fri, 12 Oct 2001 11:12:09 -0400
Subject: Re: Linux 2.4.12-ac1
To: trini@kernel.crashing.org (Tom Rini)
Date: Fri, 12 Oct 2001 16:17:39 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011012072910.N21564@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Oct 12, 2001 07:29:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15s44B-0007Vk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:
> 
> > 2.4.12-ac1
> > o	Merge the majority of 2.4.11/12
> > 	-	Fall back to the Linus reiserfs code set
> [snip]
> 
> The endian-safe patches will come back tho, right?  I don't think those
> have made it into Linus' tree yet...

Really what needs to happen is the important bits that were tested and
the reiser folks were happy with get pushed back bit by bit into both trees
now
