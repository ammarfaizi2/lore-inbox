Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263923AbUFPN1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbUFPN1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUFPN1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:27:52 -0400
Received: from CPE-203-51-26-230.nsw.bigpond.net.au ([203.51.26.230]:50937
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S263923AbUFPN1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:27:49 -0400
Message-ID: <40D04AC9.2070406@eyal.emu.id.au>
Date: Wed, 16 Jun 2004 23:27:37 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7 - problem with old gcc
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.6.7/kernel/drivers/media/video/cx88/cx8800.ko needs unknown symbol __ucmpdi2

This is a regular issue, still present when building with old gcc. I
am on Debian stable which has gcc 2.95.4.

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
