Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265101AbUFGWue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbUFGWue (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUFGWue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:50:34 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:35258 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S265101AbUFGWud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:50:33 -0400
Message-ID: <40C4F131.3060304@uni-paderborn.de>
Date: Tue, 08 Jun 2004 00:50:25 +0200
From: Bjoern Schmidt <bj-schmidt@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Flushing the swap
References: <200406072234.SAA07853@grex.cyberspace.org>
In-Reply-To: <200406072234.SAA07853@grex.cyberspace.org>
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

Hal Nine wrote:
> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.

swapoff -a
swapon -a


-- 
Greetings
Bjoern Schmidt

