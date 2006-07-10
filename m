Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965070AbWGJXwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbWGJXwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWGJXwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:52:19 -0400
Received: from smtp.ono.com ([62.42.230.12]:10979 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S965070AbWGJXwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:52:17 -0400
Date: Tue, 11 Jul 2006 01:51:30 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Adam =?UTF-8?B?VGxhxYJrYQ==?= <atlka@pg.gda.pl>,
       linux-kernel@vger.kernel.org
Subject: Cloning sound output [was Re: [Alsa-devel] OSS driver removal, 2nd
 round (v2)]
Message-ID: <20060711015130.4f558f73@werewolf.auna.net>
In-Reply-To: <44B2E4FF.9000502@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>
	<44B2E4FF.9000502@pg.gda.pl>
X-Mailer: Sylpheed-Claws 2.3.1cvs78 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 01:38:39 +0200, Adam Tlałka <atlka@pg.gda.pl> wrote:

> 
> Format changing, resampling, mixing and supporting additional plugins
> does not seems to be just low level HAL for hw device. It creates some 
> kind of virtual functionality which means more then this provided by 
> hardware device itself.
> 

Slightly OT, I just read this message from all th thread.

A quick question (you can answer me in private if this is not suitable for
this list).

How can I clone the output from one card to other ? I want to say something
like 'all PCM that goes to this emu10k1, copy it to this other card'.
Basically, I want to play music on two cards at the same time.

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam03 (gcc 4.1.1 20060518 (prerelease)) #3 SMP PREEMPT Mon
