Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRJ2QOB>; Mon, 29 Oct 2001 11:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRJ2QNv>; Mon, 29 Oct 2001 11:13:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37638 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276097AbRJ2QNm>; Mon, 29 Oct 2001 11:13:42 -0500
Subject: Re: Linux 2.4.13-ac4
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Mon, 29 Oct 2001 16:19:25 +0000 (GMT)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1011029170323.3407F-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Oct 29, 2001 05:07:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yF8I-00039G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 28 Oct 2001, Alan Cox wrote:
> 
> > o	Handle chipsets that dont get 8254 latches	(Roberto Biancardi)
> > 	right and trigger the VIA warning in error
> 
>  Hmm, has anyone tried using the "read back" 8254 command for latching,
> instead?  Chances are it's less buggy... 

Possibly. The first problem that has been pointed out however needs more
work first. That is the "so where is the 8254 locking" question

