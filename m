Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTK2Q7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 11:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbTK2Q7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 11:59:14 -0500
Received: from havoc.gtf.org ([63.247.75.124]:41396 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263808AbTK2Q65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 11:58:57 -0500
Date: Sat, 29 Nov 2003 11:54:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Julien Oster <frodoid@frodoid.org>
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       unlisted-recipients:";
	no To-header on input" <linux-kernel@vger.kernel.org>,
       marcush@onlinehome.de
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:;no To-header on input <linux-kernel@vger.kernel.org>
					     ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:;no To-header on input <linux-kernel@vger.kernel.org>
					     ^-missing end of address
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031129165455.GA14704@gtf.org>
References: <3FC36057.40108@gmx.de> <3FC8BDB6.2030708@gmx.de> <frodoid.frodo.878ylzjfjm.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.878ylzjfjm.fsf@usenet.frodoid.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 05:38:37PM +0100, Julien Oster wrote:
> I can't find the Silicon Image driver under
> 
> "SCSI low-level drivers" -> "Serial ATA (SATA) support"
> 
> under 2.6.0-test11. Just the following are there:
> 
> ServerWorks Frodo
> Intel PIIX/ICH
> Promisa SATA
> VIA SATA

You need to enable CONFIG_BROKEN :)

	Jeff



