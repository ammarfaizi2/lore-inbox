Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbTIVUWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbTIVUWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:22:34 -0400
Received: from mailserver3.hrz.tu-darmstadt.de ([130.83.126.47]:26635 "EHLO
	mailserver3.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S263174AbTIVUWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:22:33 -0400
Message-ID: <3F6F5769.2040504@hrzpub.tu-darmstadt.de>
Date: Mon, 22 Sep 2003 22:11:21 +0200
From: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: irq 9: nobody cared!
References: <3F6EBEC7.7050204@hrzpub.tu-darmstadt.de> <20030922103028.A18616@osdlab.pdx.osdl.net>
In-Reply-To: <20030922103028.A18616@osdlab.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.1, required 5,
	IN_REP_TO, REFERENCES, USER_AGENT_MOZILLA_UA, X_ACCEPT_LANG)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright schrieb:

> <snip>
>
>Can you try this patch against 2.6.0-test5-mm3?  PCI IRQ routing is
>broken in some circumstances with ACPI.
>
Thank you very, very much. Now really everything is working fine without 
any special ACPI bootparam. I've just listen to some music but no error 
message like the former ones appeared... :-)
Will this patch go into mainstrem kernel?

Thanks again,
    Ruediger

>
>thanks,
>-chris
>  
>


