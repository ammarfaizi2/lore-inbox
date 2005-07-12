Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVGLLpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVGLLpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVGLLp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:45:28 -0400
Received: from acheron.ifi.lmu.de ([129.187.214.135]:36585 "EHLO
	acheron.ifi.lmu.de") by vger.kernel.org with ESMTP id S261363AbVGLLpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:45:07 -0400
Message-ID: <42D3AD3F.9060209@bio.ifi.lmu.de>
Date: Tue, 12 Jul 2005 13:45:03 +0200
From: Frank Steiner <fsteiner-mail1@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tg3 fails with x86_64 (but works with i386)
References: <42D22059.8000607@bio.ifi.lmu.de>	 <42D379D6.5080705@bio.ifi.lmu.de> <1121156266.3171.14.camel@laptopd505.fenrus.org>
In-Reply-To: <1121156266.3171.14.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote

> you were using a binary kernel module but didn't mention it in your
> report? tsk tsk...

No, for testing fglrx that was a SuSE kernel, while I was using a
vanilla 2.6.12.2 kernel for debugging the tg3 module. Come on, first
thing I do for debugging a problem is using an untainted kernel :-)
I've learned this lesson from the LKML already :-)

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
