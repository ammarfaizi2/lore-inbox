Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTL3Lbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbTL3Lbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:31:44 -0500
Received: from mail03.mail.esat.net ([193.95.141.48]:60874 "EHLO
	mail03.mail.esat.net") by vger.kernel.org with ESMTP
	id S265766AbTL3Lbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:31:42 -0500
Message-ID: <00b001c3cec8$7d354510$6e69690a@RIMAS>
From: "Remus" <rmocius@auste.elnet.lt>
To: <linux-kernel@vger.kernel.org>
References: <20031217114125.GA20057@malvern.uk.w2k.superh.com> <3FE08470.5040801@pacbell.net> <20031218143236.GB20057@malvern.uk.w2k.superh.com> <0d6401c3c576$c6889b00$6e69690a@RIMAS>
Subject: Re: iproute2 and 2.6.0 kernel
Date: Tue, 30 Dec 2003 11:31:07 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Specialy a problem is with "ip" command.

Any ideas guys?

Thanks

Remus


> Hi folks,
>
> I have a linux box with three NICs (two for external ISP, and one local).
> Today I tried to use 2.6.0 kernel and something is wrong, because iproute2
> does not work corretly.
> No routed packets go via second ISP NIC which I use with iproute rules.
With
> 2.4.22 kernel I have no problems at all with packet routing.
>
> I compiled 2.6.0 kernel myself, maybe I missed something in .config file?
>
> Thanks
>
> Remus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

