Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272741AbTG1IoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272743AbTG1IoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:44:09 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:45736 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S272741AbTG1IoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:44:06 -0400
To: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, Otto Solares <solca@guug.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase - get_current()?
References: <9CA735B0-BEAD-11D7-BEDE-000A95A0560C@us.ibm.com>
	<buowue3l4ni.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<3F24DB59.1010600@softhome.net>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 Jul 2003 17:58:25 +0900
In-Reply-To: <3F24DB59.1010600@softhome.net>
Message-ID: <buosmorjadq.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ihar \"Philips\" Filipau" <filia@softhome.net> writes:
>    starting from -O3 gcc do always trys to do inlining.
>    was observed on gcc 3.2 and I beleive I saw the same 2.95.3
> 
>    compile this test with 02 & 03:

Um, what's your point?

-Miles
-- 
If you can't beat them, arrange to have them beaten.  [George Carlin]
