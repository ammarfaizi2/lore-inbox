Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288395AbSAHVX4>; Tue, 8 Jan 2002 16:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288393AbSAHVXq>; Tue, 8 Jan 2002 16:23:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58630 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288395AbSAHVXg>; Tue, 8 Jan 2002 16:23:36 -0500
Subject: Re: U133/48-bit
To: aaron.blew@district6.org (Aaron Blew)
Date: Tue, 8 Jan 2002 21:34:34 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), linux-kernel@vger.kernel.org
In-Reply-To: <1010522807.18421.2.camel@workmonkey> from "Aaron Blew" at Jan 08, 2002 12:46:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O3tC-0007hk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have one of the Maxtor drives and just got the card yesterday.  Will
> this card see the whole drive even without specific card support in
> 2.4.17?

Nope. You want the ide patches

