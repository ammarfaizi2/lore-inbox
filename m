Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUFPLxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUFPLxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266250AbUFPLxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:53:43 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:47554 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S266252AbUFPLxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:53:40 -0400
Message-ID: <40D034BE.2060207@uni-paderborn.de>
Date: Wed, 16 Jun 2004 13:53:34 +0200
From: Bjoern Schmidt <bj-schmidt@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kacpid takes 99% of CPU when laptop lid is closed
References: <200406161244.55502.julien.antille@eivd.ch>
In-Reply-To: <200406161244.55502.julien.antille@eivd.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.275,
	required 4, AUTH_EIM_USER -5.00, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-MailScanner-From: bj-schmidt@uni-paderborn.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antille Julien wrote:
> I can confirm that the ACPI bug I described 
> here :http://marc.theaimsgroup.com/?l=linux-kernel&m=108452002205471&w=2
> is still present in the recent 2.6.7 kernel.
> 
> However, the process taking all the CPU is kacpid now (was keventd in previous 
> kernels)

I have the same problem if i unplug ac on a compaq armada 7400.

-- 
Greetings
Bjoern Schmidt

