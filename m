Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTKDC7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 21:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTKDC7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 21:59:48 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:43916 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263619AbTKDC7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 21:59:46 -0500
Message-ID: <3FA7161E.8070804@cyberone.com.au>
Date: Tue, 04 Nov 2003 13:59:42 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org
Subject: Re: Clock skips (?) with 2.6 and games
References: <3FA62DD4.1020202@portrix.net> <3FA62F18.2050500@cyberone.com.au> <Pine.LNX.4.53.0311032136320.20595@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0311032136320.20595@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zwane Mwaikambo wrote:

>On Mon, 3 Nov 2003, Nick Piggin wrote:
>
>
>>nosmp has been broken for quite a while. If you want to try uniprocessor,
>>you'd have to compile a UP kernel.
>>
>
>Hmm? It works here even with sparse APIC IDs.
>
>

Oh? Maybe its just me then. I lose my network card and IIRC a couple
of other interrupt sources with nosmp.


