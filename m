Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTKJKtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 05:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTKJKtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 05:49:18 -0500
Received: from intra.cyclades.com ([64.186.161.6]:36746 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262888AbTKJKtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 05:49:17 -0500
Date: Mon, 10 Nov 2003 08:46:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Shane Wegner <shane-dated-1071003928.b2036e@cm.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
In-Reply-To: <20031109210527.GA1936@cm.nu>
Message-ID: <Pine.LNX.4.44.0311100846070.16790-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Nov 2003, Shane Wegner wrote:

> Hi,
> 
> I posted some weeks ago regarding a crash I was
> experiencing with 2.4.23-pre4.  I am just writing to
> confirm that 2.4.23-pre9 is still unable to run relyably on
> this machine.  In my earlier post, I thought acpi might be
> the culprit as I had it enabled due to a bios bug.  Intel
> since fixed that so I was able to boot 2.4.23-pre9 with
> acpi totally disabled in make config.

Shane,

Tracking down which -pre this started to happen would help a lot.

