Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbTG0Obp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTG0Obp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:31:45 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:46502 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270800AbTG0Obo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:31:44 -0400
Message-ID: <3F23E612.8070803@softhome.net>
Date: Sun, 27 Jul 2003 16:47:46 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: romieu@fr.zoreil.com
Subject: Re: OT: Vanilla not for embedded?! Re: Kernel 2.6 size increase -
  get_current()?
References: <dUQT.72E.5@gated-at.bofh.it> <dUQT.72E.7@gated-at.bofh.it> <dUQT.72E.9@gated-at.bofh.it> <dUQT.72E.11@gated-at.bofh.it> <dUQT.72E.13@gated-at.bofh.it> <dUQT.72E.3@gated-at.bofh.it>
In-Reply-To: <dUQT.72E.3@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar "Philips" Filipau wrote:
> 
> P.S. To my earlier 'far from vanilla' comment (-x '.*' - to skip 
> .depend/.config/etc):
> $ diff -urN -x '.*' ./linux-2.4.17 \
> /opt/hardhat/devkit/lsp/ibm-walnut-ppc_405/linux-2.4.17_mvl21\
> | wc -l
>     1128089
> $
> and more than 500 additional CONFIG_* parameters comparing to vanilla.
> 

   Oops sorry - some garbage get into.
   Much less than 500 - cannot count precisely.
   513 with garbage - cannot filter out correctly what is present in 
vanilla kernel...

   mvl21 patch againt vanilla _impressive_ by all means.
   'diff -urN' output is more than 30MB.

