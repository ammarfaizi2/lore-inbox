Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTKQSJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTKQSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:09:06 -0500
Received: from ns.km0938.keymachine.de ([62.141.48.247]:5098 "EHLO
	km0938.keymachine.de") by vger.kernel.org with ESMTP
	id S263647AbTKQSJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:09:02 -0500
Message-ID: <3FB90EA8.8020006@ng.h42.de>
Date: Mon, 17 Nov 2003 19:08:40 +0100
From: Lars Ehrhardt <1103@ng.h42.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.0-test9-bk22 does not compile on sparc64: undefined
 reference to `vga_writeb'
References: <Pine.GSO.4.33.0311171131070.26356-100000@sweetums.bluetronic.net> <3FB8FCA6.7010804@ng.h42.de> <Pine.LNX.4.51.0311171802350.14956@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.51.0311171802350.14956@dns.toxicfilms.tv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:

>> Maybe the help text for VGA_CONSOLE should be adjusted accordingly?
>> By reading "Virtually everyone wants that." in the help text I did not
>> assume that this option does not make sense on Sparcs.
>
> Maybe :) How about this:
> (...)

Yeah, that'll work.
OTOH, if this config option really does not make sense on sparcs at all
it might even be better to completely hide it, if that is possible.

Kind regards

Lars Ehrhardt



