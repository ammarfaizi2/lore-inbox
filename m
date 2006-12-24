Return-Path: <linux-kernel-owner+w=401wt.eu-S1752881AbWLXVax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbWLXVax (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 16:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbWLXVax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 16:30:53 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:41396 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752881AbWLXVaw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 16:30:52 -0500
From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Guillaume Chazarain <guichaz@yahoo.fr>
Subject: Re: ACPI EC warnings
Date: Sun, 24 Dec 2006 23:30:52 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612242247.06989.ismail@pardus.org.tr> <200612242305.59729.ismail@pardus.org.tr> <458EEEC6.4000406@yahoo.fr>
In-Reply-To: <458EEEC6.4000406@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612242330.52697.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

24 Ara 2006 Paz 23:19 tarihinde, Guillaume Chazarain şunları yazmıştı: 
> > Patch looks nice,
>
> But LKML didn't like gmail's HTML so here is it again. Hopefully this
> one will pass.

I think this one didn't pass either :-/

> > btw do you notice any skippy behaviour? i.e sound skips when
> > I get this warning
>
> No, in my case I just get the message: ACPI: EC: evaluating _Q20
>
> > or something else is broken and I blame ACPI because its
> > flooding dmesg =)
>
> I happen to have at the moment some other debugging printk, flooding
> my logs, and sound doesn't skip either :-) Asus V6VA - Pentium-M 2GHz here.

Yeah the warning seems unrelated to skips.

Regards,
ismail

-- 
2 + 2 = 5 for very large values of 2
