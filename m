Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbSJXSKj>; Thu, 24 Oct 2002 14:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265576AbSJXSKj>; Thu, 24 Oct 2002 14:10:39 -0400
Received: from mail-in2.inet.tele.dk ([194.182.148.151]:625 "HELO
	mail-in2.inet.tele.dk") by vger.kernel.org with SMTP
	id <S265575AbSJXSKi>; Thu, 24 Oct 2002 14:10:38 -0400
Message-ID: <3DB839B9.5010701@sentinel.dk>
Date: Thu, 24 Oct 2002 20:19:37 +0200
From: Frederik Dannemare <tux@sentinel.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; da-DK; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: da, en
MIME-Version: 1.0
To: Frank Jacobberger <f1j1@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart fails to load in 2.4.20-pre10-ac1
References: <3DB6875E.6080306@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Jacobberger skrev:
> Shows support in pre7-ac1 for
> 
> Add SIS646 (645DX) PCI idents for AGP        (Murray Root)
> 
> I have tried in vain to get agpgart to load with 2.4.20-pre10-ac1 after 
> enabling
> SiS support in character devices.

I'm using 2.4.20-pre8-ac3 with the ASUS P4S533 mobo (645dx chipset). 
AGPGART work fine here with SIS support enabled, so maybe try this 
(slightly older) kernel.

/frederik

