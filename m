Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272951AbTG3QZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272958AbTG3QZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:25:32 -0400
Received: from eth1.smtp2.surewest.net ([66.60.129.26]:62884 "HELO
	smtp2.surewest.net") by vger.kernel.org with SMTP id S272951AbTG3QZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:25:29 -0400
Message-ID: <3F27F224.5010806@royfranz.com>
Date: Wed, 30 Jul 2003 09:28:20 -0700
From: Roy Franz <lists@royfranz.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 / 2.6 802.11g 54Mbs support ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TST: SMTP2 SNWK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I could not find anything regarding $SUBJECT.
> Next week I will be getting the Netgear WG602 (Access point),
> WG511 (PCMCIA  card) and WG311 (PCI card), all of which are
> 54 Mbs 802.11g compliant.
> I will be able to test the PCI card on both 2.4 and 2.6.
> The PCMCIA card only under 2.4
> (My old (1999) via-based laptop doesn't like 2.6 but that's another
> story)
> 
> 
> Margit 
> 



The only support that I am aware of is for the Atheros a, a/b, and a/b/g
chipsets.  Atheros has released a binary only driver (still very beta) -
for more info see:

http://sourceforge.net/projects/madwifi

Also, there is an effort to create an opensource driver for this
hardware at:

http://team.vantronix.net/ar5k/

This is driver is in its very early stages, only useful for serious
developers.

I am not aware of any drivers or efforts involving the Broadcom b/g
chipset, which seems to be the dominant chipset for b/g products.
(Although I don't know what radio the products you mentioned are based on.)

Roy



