Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTL1RCc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTL1RCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:02:32 -0500
Received: from intra.cyclades.com ([64.186.161.6]:11707 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261827AbTL1RCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:02:31 -0500
Date: Sun, 28 Dec 2003 14:56:45 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
In-Reply-To: <S261660AbTL1Q0E/20031228162604Z+16979@vger.kernel.org>
Message-ID: <Pine.LNX.4.58L.0312281456090.15034@logos.cnet>
References: <S261660AbTL1Q0E/20031228162604Z+16979@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Dec 2003, Nicklas Bondesson wrote:

> I really hope so :) I think you should wrap it up and send it to the list
> marked as [PATCH].
>
> Many thanks for the help again!

Nicklas,

Have you tried to compile the kernel with CONFIG_PDC202XX_FORCE unset ?
