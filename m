Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVAGPps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVAGPps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVAGPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:44:55 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:31681 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S261467AbVAGPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:43:13 -0500
Subject: Re: Linux 2.6.10-ac5
Date: Fri, 07 Jan 2005 16:42:47 +0100
Organization: Chemnitz University of Technology
Message-ID: <87r7kxmeiw.fsf@kosh.ultra.csn.tu-chemnitz.de>
References: <1105058480.24187.308.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
Cancel-Lock: sha1:wslvy7P9+yraWpdzTv5kG84Kc/s=
X-Spam-Score: -5.898 () ALL_TRUSTED,AWL,BAYES_00
X-Spam-Score: -5.898 () ALL_TRUSTED,AWL,BAYES_00
Reply-To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 3.0.1 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 706061e527a23eaab6b0df22823cde1c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

> Forward ported from 2.6.9-ac
> o	More ATI IDE PCI identifiers			(Enrico Scholza)
                                                                      ^
                                                    this is too much...

Please move the SATA device (4379) into the sata_sil.c driver. See
http://marc.theaimsgroup.com/?l=linux-ide&m=110357606225070&w=2



Enrico

