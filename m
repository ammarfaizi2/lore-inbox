Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270621AbTHJSyn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 14:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270622AbTHJSyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 14:54:43 -0400
Received: from [66.212.224.118] ([66.212.224.118]:22029 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270621AbTHJSym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 14:54:42 -0400
Date: Sun, 10 Aug 2003 14:42:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       Linux Lernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Yamaha opl3sa2 under 2.4.20 and ongoing PCMCIA &
 USB problems on 2.6.0-test2
In-Reply-To: <Pine.LNX.4.53.0308072127590.12875@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0308101442240.31799@montezuma.mastecende.com>
References: <3F32417D.3090000@longlandclan.hopto.org>
 <Pine.LNX.4.53.0308072127590.12875@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Zwane Mwaikambo wrote:

> On Thu, 7 Aug 2003, Stuart Longland wrote:
> 
> > Under 2.4.20:
> > 	Everything works flawlessly, except the sound card (Yamaha OPL3-SAx)
> > refuses to work, the opl3sa2 driver does not recognise the card.
> 
> Hmm i wonder how that got broken..
> 
> > Is it possible to, say, backport the opl3sa2 driver to Linux 2.4.2x?
> 
> I'll fix the 2.4 one instead, there are a number of differences in the PnP 
> system in 2.5 and 2.4 which would make backporting more work (with more 
> likelyhood of bugs being introduced).

Could you please send me /var/log/dmesg from 2.4 and 2.6

Thanks,
	Zwane

