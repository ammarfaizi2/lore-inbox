Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWFGTzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWFGTzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 15:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFGTzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 15:55:38 -0400
Received: from mail.feitoza.com.br ([72.20.27.67]:55435 "EHLO
	mail.feitoza.com.br") by vger.kernel.org with ESMTP id S932399AbWFGTzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 15:55:38 -0400
Message-ID: <44872F33.7020708@feitoza.com.br>
Date: Wed, 07 Jun 2006 16:55:31 -0300
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Reply-To: marcelo@feitoza.com.br
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Need pci=conf1 to have my PCI slots working
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Motherboard: Asus P5VDC-MX
Northbridge: VIA P4M800 PRO
Southbridge: VIA VT8251
Kernel Version: 2.6.15-23-386 (Ubuntu Dapper Drake original kernel)

My PCI cards where not being showed on lspci and lshw. Tried to change
cards, change slots, nothing worked. So someone told me to try pci=conf1
in my boot, and it worked.He then told me that you people might be
interested in hearing that was necessary and then cowardly ran off.

Best regards

-- 
Marcelo Feitoza Parisi
marcelo@feitoza.com.br
http://marcelo.feitoza.com.br/
Key ID: 0x42A42C9A
Key fingerprint: ADDE EEE7 57D9 FB45 2605 5A03 54DA 3079 42A4 2C9A
Key: http://marcelo.feitoza.com.br/GnuPG/chave_publica.asc
