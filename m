Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVFEPBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFEPBF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 11:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFEPBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 11:01:05 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:63461 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S261573AbVFEPBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 11:01:03 -0400
Message-ID: <42A3176F.9030307@freemail.hu>
Date: Sun, 05 Jun 2005 17:17:03 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
References: <42A2A0B2.7020003@freemail.hu>	<42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org> <42A2BC4B.5060605@freemail.hu> <42A2CF27.8000806@freemail.hu>
In-Reply-To: <42A2CF27.8000806@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi írta:
> I will try some older kernels, too.

OK, I tried 2.6.12-rc5, -rc4, -rc3, -rc2, same problem.
Strangest thing is, after gpm starts, I can use the USB mice
on the console. When X starts, the mice die. DRI bug?
I will try even earlier kernels, too.

Best regards,
Zoltán Böszörményi
