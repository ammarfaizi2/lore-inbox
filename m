Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267760AbUHXNHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267760AbUHXNHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUHXNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:07:37 -0400
Received: from ws.spps.com.br ([200.248.176.2]:23703 "EHLO ws.spps.com.br")
	by vger.kernel.org with ESMTP id S267791AbUHXNGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:06:35 -0400
Message-ID: <412B3D26.20701@quatro.com.br>
Date: Tue, 24 Aug 2004 10:05:42 -0300
From: =?ISO-8859-1?Q?=22Fernando_O=2E_Kornd=F6rfer=22?= 
	<fok@quatro.com.br>
Reply-To: fok@quatro.com.br
Organization: Quatro =?ISO-8859-1?Q?Inform=E1tica_Ltda=2E?=
User-Agent: Mozilla Thunderbird 0.7 (Windows/20040616)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Skeggs <d4rk74m4@intas.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: HDD LED doesn't light.
References: <200408240526.i7O5QBOT025006@svr1.intas.net.au>
In-Reply-To: <200408240526.i7O5QBOT025006@svr1.intas.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SPPS-MailScanner-Information: Contate a SPPS para maiores informacoes. +55 (51) 582-3666
X-SPPS-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a hardware problem, as I have similar hardware (Asus 
A7N8x-e deluxe) and the HDD Led also stays off.
BTW, I'm using MS-Windows(R).

Tell me something, you'r using SATA, right?


Ben Skeggs wrote:

>Hello,
>
>No matter how much harddisk activity is occuring on my system, the 
>harddisk LED stays off.  At first I thought I'd misconnected the lead, 
>but under Windows the light is functional.
>
>This occurs on both my SATA harddisk and my PATA harddisk.
>
>SATA controller: Silicon Image sil3112
>PATA controller: NForce2
>Motherboard    : Abit NF7-S 2.0
>CPU            : AthlonXP 3000+
>
>The earliest kernel I've used with this hardware is 2.6.6, and the 
>problem occurs right up to 2.6.8.1.
>
>I'm completely clueless as I was under the impression that the hardware 
>controlled the LED.
>
>Could I please be CC'd any replies as I'm not subscribed to the list.
>
>Regards,
>Ben Skeggs
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
