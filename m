Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWHATBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWHATBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWHATBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:01:42 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:51432 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751787AbWHATBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:01:41 -0400
Message-ID: <44CF428A.8000402@namesys.com>
Date: Tue, 01 Aug 2006 06:01:14 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregory Maxwell <gmaxwell@gmail.com>
CC: David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>	 <1154446189.15540.43.camel@localhost.localdomain>	 <44CF84F0.8080303@slaphack.com> <e692861c0608011004x2ac1d9fcu353cd8e0d72eaac4@mail.gmail.com>
In-Reply-To: <e692861c0608011004x2ac1d9fcu353cd8e0d72eaac4@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

> This is why ZFS offers block checksums... it can then try all the
> permutations of raid regens to find a solution which gives the right
> checksum.
>
ZFS performance is pretty bad in the only benchmark I have seen of it. 
Does anyone have serious benchmarks of it?  I suspect that our
compression plugin (with ecc) will outperform it.
