Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVLDPUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVLDPUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVLDPUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:20:22 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:26620 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932246AbVLDPUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:20:21 -0500
Message-ID: <43930A5F.9050802@student.ltu.se>
Date: Sun, 04 Dec 2005 16:25:19 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de> <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org> <20051204142551.GB4769@merlin.emma.line.org>
In-Reply-To: <20051204142551.GB4769@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>As I say, these aren't licensed for inclusion into the kernel, they bear
>a (C) Copyright notice and "All rights reserved."
>  
>
In the 2.6.15-rc5 kernel we find:
data@amazon linux-2.6.15-rc5]$ find . -name *.[chS] | xargs grep -n "All 
rights reserved" | wc -l
932
[data@amazon linux-2.6.15-rc5]$ find . -name *.[chS] | xargs grep -n 
"Copyright" | wc -l
15083

But I do wonder how copyright and GPL can co-exist. Do the copyright 
holder own the changes anybody else does to the code?
Anyone care to explain?

Thanks
Richard Knutsson

