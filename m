Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbVHSXBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbVHSXBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbVHSXBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:01:34 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:52700 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S932742AbVHSXBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:01:33 -0400
Message-ID: <430664C8.1090000@home.nl>
Date: Sat, 20 Aug 2005 01:01:28 +0200
From: Simon Oosthoek <s.oosthoek@home.nl>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050711)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SATA status report updated
References: <4AA7B-4jm-5@gated-at.bofh.it> <4DagM-7c8-43@gated-at.bofh.it> <871x4ql24a.fsf@ABG3595C.abg.fsc.net> <43062623.607@pobox.com>
In-Reply-To: <43062623.607@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Yes, that's why I have resisted the "just add the PCI ID" patches that 
> have cropped up.
> 
> SiS submitted patches that duplicated portions of libata inside their 
> driver, rather than simply fixing libata as would be proper.
> 
> So we are stuck in the middle :(
> 
> Someone needs to work with the SiS submission until it's kosher with the 
> upstream kernel, then everybody will be happy.

I know Mandriva is on the ball and a bug with some information and an 
updated patch is on the kernel bugme...

http://qa.mandriva.com/show_bug.cgi?id=17654
http://bugme.osdl.org/show_bug.cgi?id=4192

I'd say it's important to get some proper fix in a distribution soon (so 
I can use my new PC ;-)

Cheers

Simon
