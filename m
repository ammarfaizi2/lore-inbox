Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287171AbSABXHy>; Wed, 2 Jan 2002 18:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287981AbSABXHZ>; Wed, 2 Jan 2002 18:07:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15631 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287171AbSABXFs>; Wed, 2 Jan 2002 18:05:48 -0500
Subject: Re: ISA slot detection on PCI systems?
To: dalgoda@ix.netcom.com
Date: Wed, 2 Jan 2002 23:16:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102225329.GB29462@thune.mrc-home.com> from "Mike Castle" at Jan 02, 2002 02:53:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LucJ-0005xU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What's wrong with a startup routine that includes something like:
> 
> dmidecode > /var/run/dmi

Absolutely nothing, and that also handily means it isnt setuid  8)
