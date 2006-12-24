Return-Path: <linux-kernel-owner+w=401wt.eu-S1752874AbWLXVGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbWLXVGA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 16:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbWLXVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 16:05:59 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:60628 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752871AbWLXVF6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 16:05:58 -0500
From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: "Guillaume Chazarain" <guichaz@gmail.com>
Subject: Re: ACPI EC warnings
Date: Sun, 24 Dec 2006 23:05:58 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612242247.06989.ismail@pardus.org.tr> <3d8471ca0612241302j5d4a92cdi84eec81e0739aa2@mail.gmail.com>
In-Reply-To: <3d8471ca0612241302j5d4a92cdi84eec81e0739aa2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612242305.59729.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

24 Ara 2006 Paz 23:02 tarihinde, Guillaume Chazarain şunları yazmıştı: 
> 2006/12/24, Ismail Donmez <ismail@pardus.org.tr>:
> > ACPI: EC: evaluating _Q60
>
> Same thing here, I think it is caused by
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>it;h=af3fd1404fd4f0f58ebbb52b22be4f1ca0794cda
>
> The attached patch restores the previous behaviour.

Patch looks nice, btw do you notice any skippy behaviour? i.e sound skips when 
I get this warning or something else is broken and I blame ACPI because its 
flooding dmesg =)

Regards,
ismail

-- 
2 + 2 = 5 for very large values of 2
