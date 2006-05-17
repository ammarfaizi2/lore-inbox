Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWEQNZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWEQNZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWEQNZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:25:12 -0400
Received: from web51410.mail.yahoo.com ([206.190.38.189]:37227 "HELO
	web51410.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932269AbWEQNZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:25:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vXb9O3A6mCkm3/gPEqvuPpFQQTDstuIx6KToEHHhbaUBcpQfeubTjZhMHdoq22bkdDSPblHrPa/Wm8M/foUN2eZDuKmez8LU2YWik/OgyoaRIPy3p+a8ggwBiPCA5QRicw7iPGBe+Q1GA1YYtslVCCa2WgntpClyi/0fet+MI6s=  ;
Message-ID: <20060517132503.79272.qmail@web51410.mail.yahoo.com>
Date: Wed, 17 May 2006 15:25:02 +0200 (CEST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: Wiretapping Linux?
To: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <446B141B.7050506@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Avi Kivity schrieb:
> 
> A pci device can read system RAM and other memory-mapped PCI devices 
> (such as display framebuffers) using DMA. In addition, a pci (but not 
> pci-express) device can snoop on pci bus traffic to other devices. 
> Typically, however, hard drive controllers will be integrated into the 
> chipset so the data is not on the bus.

Thanks for providing this information. This makes the binary firmware
required for peripherals even more interesting for security conscious
people.

Regards
  Joerg

-- 
Regards
       Joerg



	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de
