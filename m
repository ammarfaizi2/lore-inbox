Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTD1DgC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 23:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTD1DgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 23:36:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263407AbTD1DgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 23:36:02 -0400
Message-ID: <3EACA476.8090201@pobox.com>
Date: Sun, 27 Apr 2003 23:48:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate CONFIG_TULIP_MWI
References: <Pine.GSO.4.21.0304171829030.10220-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0304171829030.10220-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> CONFIG_TULIP_MWI is duplicated in
> linux-2.4.21-pre7/Documentation/Configure.help. Which one is correct?


fixed, will send patch to Marcelo soon (but for 2.4.22)

