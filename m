Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWEPEdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWEPEdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 00:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWEPEdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 00:33:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:40126 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751264AbWEPEdD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 00:33:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kccQtKExbU90wvWXQnn6SPQHEOooi0jHVTxOKtySP6X6TIA9TpePDEKyPHTr9znROREe0byFIid1wXWPGtG9FL1YjhYBm+eLPO7mCZfjB9y3fMna4KJfLtc+xjIBiMTW8ygpmHh5OaNPUkpmQ8z0j2ybqZwL48KrUhGjYt/0OAY=
Message-ID: <3aa654a40605152133x516581f9w62c7cb7709864fb0@mail.gmail.com>
Date: Mon, 15 May 2006 21:33:02 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
In-Reply-To: <44694C4F.3000008@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060515170006.GA29555@havoc.gtf.org>
	 <3aa654a40605151630j53822ba1nbb1a2e3847a78025@mail.gmail.com>
	 <446914C7.1030702@garzik.org>
	 <3aa654a40605152036h40fa1cd0x8edd81431c1bd22d@mail.gmail.com>
	 <44694C4F.3000008@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:


> Can you configure your interrupts so that ethernet and SATA are not on
> the same irq?

Sorry, need a little hand holding here. I'm unsure how to do such a
thing, and can't really google that.

> Also, please provide _full_ dmesg and _full_ lspci, not just the
> SATA-related stuff.  This looks motherboard- or hardware-related.

kern.log is my last 24 hrs, contains everything that came into the kern.log
http://olricha.homelinux.net:8080/dump/kern.log
http://olricha.homelinux.net:8080/dump/lspci-vvv

If there's anything else I can do please let me know
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
