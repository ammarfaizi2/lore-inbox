Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSHKT2k>; Sun, 11 Aug 2002 15:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318334AbSHKT2k>; Sun, 11 Aug 2002 15:28:40 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:274 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S318333AbSHKT2j>;
	Sun, 11 Aug 2002 15:28:39 -0400
From: <Hell.Surfers@cwctv.net>
To: Devilkin-LKML@blindguardian.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Aug 2002 20:32:02 +0100
Subject: RE:Re: Re: 2.4.19 IDE Partition Check issue (again)
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1029094322136"
Message-ID: <00b752231190b82DTVMAIL8@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1029094322136
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

first thing i did...



On 	Sun, 11 Aug 2002 21:25:41 +0200 	Devilkin <Devilkin-LKML@blindguardian.org> wrote:

--1029094322136
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sun, 11 Aug 2002 20:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSHKTTF>; Sun, 11 Aug 2002 15:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318238AbSHKTTF>; Sun, 11 Aug 2002 15:19:05 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:48583 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S318237AbSHKTTE> convert rfc822-to-8bit; Sun, 11 Aug 2002 15:19:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by horkos.telenet-ops.be (Postfix) with SMTP id 827F183D46
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2002 21:22:47 +0200 (CEST)
Received: from whocares.fcbs.net (D5E0EE8C.kabel.telenet.be [213.224.238.140])
	by horkos.telenet-ops.be (Postfix) with SMTP id 566B28455A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2002 21:22:47 +0200 (CEST)
Received: (qmail 919 invoked by uid 1005); 11 Aug 2002 19:25:41 -0000
Received: from Devilkin-LKML@blindguardian.org by whocares
	 by uid 1002 with qmail-scanner-1.10 (F-PROT: 3.12. Clear:0. Processed in 0.066724 secs); 11 Aug 2002 19:25:41 -0000
X-Qmail-Scanner-Mail-From: Devilkin-LKML@blindguardian.org via whocares
X-Qmail-Scanner: 1.10 (Clear:0. Processed in 0.066724 secs)
Received: from localhost (HELO whocares) (devilkin@127.0.0.1)
  by localhost with SMTP; 11 Aug 2002 19:25:41 -0000
Content-Type: text/plain; charset=US-ASCII
From: Devilkin <Devilkin-LKML@blindguardian.org>
To: <Hell.Surfers@cwctv.net>
Subject: Re: Re: 2.4.19 IDE Partition Check issue (again)
Date: Sun, 11 Aug 2002 21:25:41 +0200
User-Agent: KMail/1.4.1
References: <09e824508190b82DTVMAIL1@smtp.cwctv.net>
In-Reply-To: <09e824508190b82DTVMAIL1@smtp.cwctv.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208112125.41416.Devilkin-LKML@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Sunday 11 August 2002 21:08, Hell.Surfers@cwctv.net wrote:
> i have a liveEVAL cd (SuSE 7.3) and a maxtor hard disk et 686, it freezes
> on writing bootloader, hangs with a constantbeep.. I wonder if this is
> related...

Have you disabled you BIOS' bootsector virus protection?

This often causes such beeps...

DK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1029094322136--


