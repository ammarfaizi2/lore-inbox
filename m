Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268154AbUBRV2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUBRV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:28:32 -0500
Received: from adsl-67-65-232-1.dsl.lgvwtx.swbell.net ([67.65.232.1]:31492
	"HELO rooker.dyndns.org") by vger.kernel.org with SMTP
	id S268154AbUBRV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:27:27 -0500
Message-ID: <000501c3f665$e8b2af20$6600a8c0@pixl>
From: "Peter Maas" <peter@goquest.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
Date: Wed, 18 Feb 2004 15:26:42 -0600
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

http://www.theinquirer.net/?article=14222

____________________________________________________________________

Ok,
now that Intel has finally come clean about their x86-64 implementation
(see

http://www.intel.com/technology/64bitextensions/index.htm?iid=techtrends+spotlight_64bit

for full details), can somebody write up a list of differences? I know
there are people who have had access to the Intel docs for a while now,
and obviously Intel is too frigging proud to list the differences
explicitly.

>From what I can tell from a quick look, it looks like it is basically just
the 3DNow vs SSE3 thing, but I assume there are other details too. Can
people who have been involved with this make a quick list for the rest of
us who only got to see the final details today?

(And I assume there's somebody with a few patches pending..)

Thanks,
Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@xxxxxxxxxxxxxxx
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/

