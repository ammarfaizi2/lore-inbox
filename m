Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265575AbUAMTNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265578AbUAMTNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:13:55 -0500
Received: from forty.greenhydrant.com ([208.48.139.185]:6577 "EHLO
	forty.greenhydrant.com") by vger.kernel.org with ESMTP
	id S265575AbUAMTNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:13:51 -0500
Message-ID: <1694.208.48.139.163.1074021230.squirrel@www.greenhydrant.com>
In-Reply-To: <20040113185948.GA17867@axis.demon.co.uk>
References: <798DD0DBF172864C8CC752175CF42BA326C8B2@pat.aberdeen.paradigmgeo.com>
    <20040113185948.GA17867@axis.demon.co.uk>
Date: Tue, 13 Jan 2004 11:13:50 -0800 (PST)
Subject: Re: kernel oops 2.4.24
From: "David Rees" <drees@greenhydrant.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, January 13, 2004 1at 0:59 am, Nick Craig-Wood wrote:
> On Tue, Jan 13, 2004 at 11:44:18AM -0000, Paul Symons wrote:
>> I'm having a few problems with 2.4.24. I keep suffering oops's when
>> performing intensive operations.
>>
>> Hardware: VIA EPIA 5000 / C3 processor
>
> I've been extensively thrashing one of these recently.  I've compiled
> several kernels for it, but all with the "CyrixIII" for VIA Cyrix III
> or VIA C3 option.  This sets CONFIG_MCYRIXIII.
>
> Have you tried memset86 on the hardware?

I think you mean memtest86... (in case anyone was confused)

-Dave
