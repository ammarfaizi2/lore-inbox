Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290084AbSA3Qqa>; Wed, 30 Jan 2002 11:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290018AbSA3QpP>; Wed, 30 Jan 2002 11:45:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290080AbSA3Qoq>; Wed, 30 Jan 2002 11:44:46 -0500
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Wed, 30 Jan 2002 16:57:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        michelpereira@uol.com.br (Michel Angelo da Silva Pereira),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0201301805200.5518-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Jan 30, 2002 06:06:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Vy3B-0007mh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 30 Jan 2002, Alan Cox wrote:
> 
> > Ok the oops is not nice. The timeouts point to i2o_scsi and/or the serveraid
> > in i2o mode not liking one another (it has an official native mode driver
> > too btw which is the one you wanted)
> 
> Is that the one supplied on Intel's site? Or is there a kernel supported 
> one?

ServeRAID is IBM - its kernel supported and also on IBM's site.
