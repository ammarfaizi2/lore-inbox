Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTEKM4S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbTEKM4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:56:18 -0400
Received: from pb148.mielec.sdi.tpnet.pl ([80.49.1.148]:14341 "EHLO
	enigma.put.mielec.pl") by vger.kernel.org with ESMTP
	id S261312AbTEKM4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:56:17 -0400
Message-ID: <3EBE4B64.8070800@put.mielec.pl>
Date: Sun, 11 May 2003 15:08:52 +0200
From: Grzegorz Wilk <toulouse@put.mielec.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; PL; rv:1.3) Gecko/20030312
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SiS648 support for agpgart, kernel 2.4.21-rc2-ac1
References: <Pine.SOL.4.30.0305111409470.1501-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0305111409470.1501-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uzytkownik Bartlomiej Zolnierkiewicz napisal:
> On Sun, 11 May 2003, Grzesiek Wilk wrote:

>>One thing i'm not sure is in which agp mode it is working. SiS648 as well as
>>R9k supports agp 3.0 but I don't think that generic sis driver does.
>>(correct me if i'm wrong).
> 
> 
> You are wrong, R9k -> no AGP3.0 ;-).
> --
> Bartlomiej

I'm quite certain, that R2k _is_ agp 3.0 compatible.
Following the specification at
http://mirror.ati.com/products/pc/radeon9000pro/specs.html:
"...with AGP 2X (3.3v), 4X (1.5V), 8X (0.8v) or Universal AGP 3.0 bus
configuration (2X/4X/8X)."

So is ATI making a mickey of me or what?

