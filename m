Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbTFIOr4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 10:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTFIOr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 10:47:56 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:63494 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S264424AbTFIOry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 10:47:54 -0400
Message-ID: <3EE4A14C.3000109@inet6.fr>
Date: Mon, 09 Jun 2003 17:01:32 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Completely disable AT/PS2 keyboard support in 2.4?
References: <Pine.GSO.4.21.0306091529480.1347-100000@vervain.sonytel.be> <1055169922.4052.3.camel@paragon.slim>
In-Reply-To: <1055169922.4052.3.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:

>My arrow keys are working just fine. The "can't emulate rawmode for
>keycode" messages seem to appear without a key being pressed. The
>keyboard or the keyboard receiver (it's a wireless keyboard) is probably
>just sending out keycodes at will...
>  
>

On my config (Logitech wireless mouse and kb with USB receiver) :
- 272 keycode happens on each left click,
- 273 or 276 on each right click (actual button pressed dependant there 
are 2 buttons recognised as the right one on my Optical Trackman),
- 275 on each middle click,
- 274 on each wheel click...

Hope it helps.

LB

