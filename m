Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGAG7G>; Mon, 1 Jul 2002 02:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSGAG7F>; Mon, 1 Jul 2002 02:59:05 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8971 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315431AbSGAG7F>; Mon, 1 Jul 2002 02:59:05 -0400
Message-Id: <200207010657.g616voT17255@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Nix <nix@esperi.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 (and maybe earlier versions) can't see my IDE disks where 2.2 can
Date: Mon, 1 Jul 2002 09:57:36 -0200
X-Mailer: KMail [version 1.3.2]
References: <871yao7erp.fsf@amaterasu.srvr.nix>
In-Reply-To: <871yao7erp.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 June 2002 17:22, Nix wrote:
> I'm using a ten year old 486 as a firewall, with an aged transparent
> 2.5Mb Promise caching IDE controller managing a couple of fairly
> bog-standard IDE disks (one a 420Mb 1989-vintage Western Digital of some
> kind, the other a 1994-vintage 1Gb IBM disk). I can't find out the model
> numbers without taking the machine to pieces, because even with 2.2.20
> the (new) ide driver says

If 2.4 kernel does not work:
Andre Hedrick <andre@linux-ide.org> [09 apr 2002]
	ATA/ATAPI Storage Architect [2.0,2.2,2.4]
	HBA interface developer
	Serial ATA Architect [future release]
	Voting NCITS member AT-Attachment Committee

If 2.5 kernel does not work:
Martin Dalecki <martin@dalecki.de> [11 mar 2002]
	IDE subsystem maintainer for 2.5
	(mail Vojtech Pavlik <vojtech@suse.cz> too)

Include lspci data and .config
--
vda
