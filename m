Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSFLIgx>; Wed, 12 Jun 2002 04:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFLIgw>; Wed, 12 Jun 2002 04:36:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2053 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312498AbSFLIgv>; Wed, 12 Jun 2002 04:36:51 -0400
Subject: Re: Serverworks OSB4 in impossible state
To: Martin.Wilck@Fujitsu-Siemens.com (Martin Wilck)
Date: Wed, 12 Jun 2002 09:58:32 +0100 (BST)
Cc: osb4-bug@ide.cabal.tm,
        linux-kernel@vger.kernel.org (Linux Kernel mailing list),
        Martin.Wilck@Fujitsu-Siemens.com (Martin Wilck)
In-Reply-To: <1023724379.23630.309.camel@biker.pdb.fsc.net> from "Martin Wilck" at Jun 10, 2002 05:52:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I3xY-0007Hu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Triggering the check on csb5/csb6 would be a bug - maybe an extra 
test is needed there as CSB5/6 are fine
