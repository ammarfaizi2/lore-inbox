Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSA3Ker>; Wed, 30 Jan 2002 05:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289085AbSA3Keh>; Wed, 30 Jan 2002 05:34:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289081AbSA3KeY>; Wed, 30 Jan 2002 05:34:24 -0500
Subject: Re: 2.4.18-pre7 Ali chipset performance
To: david@atrey.karlin.mff.cuni.cz
Date: Wed, 30 Jan 2002 10:46:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020130112541.A1215@pidaibm.in.idoox.com> from "David Hajek" at Jan 30, 2002 11:25:41 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VsGN-0006zA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can get around ~8mb/s with hdparm. With 
> stock 2.4.9-21 redhat kernel I can get 18mb/s, but
> random lookups occured. 

I'd be interested to know how 2.4.18pre7-ac1 behaves - that has the newer
Andre IDE driver work and some other changes that may be relevant. 

Also if you can get lockups from 2.4.9-21 please do stick a bug in
https://bugzilla.redhat.com/bugzilla with whatever diagnostics you can get
(if any) and the hw info
