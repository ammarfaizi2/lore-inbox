Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272384AbTGYXcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272386AbTGYXcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:32:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43904
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S272384AbTGYXcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:32:21 -0400
Subject: Re: Sound recording problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pablo Baena <pbaena@uol.com.ar>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1059158899.1116.29.camel@hal>
References: <1059158899.1116.29.camel@hal>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059176605.1204.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Jul 2003 00:43:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-25 at 19:48, Pablo Baena wrote:
> I'll focus on my actual configuration, so I can debug the problem. I
> have a SB16 Awe ISA, and I tried the OSS drivers with 2.6.0-test1.
> I have a VIAC686 motherboard, with a K7 650Mhz processor.

Right now you need the ALSA drivers for recording on VIA. Fixing the
OSS one is down on the todo list somewhere but nobody has tackled it

