Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVHDPdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVHDPdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVHDPdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:33:19 -0400
Received: from wine.ocn.ne.jp ([220.111.47.146]:51960 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S262583AbVHDPbP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:31:15 -0400
To: Matt_Domsch@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Could you please check mail configuration?
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
References: <200508042245.IEC40094.631911@I-love.SAKURA.ne.jp>
	<20050804140543.GA16674@lists.us.dell.com>
In-Reply-To: <20050804140543.GA16674@lists.us.dell.com>
Message-Id: <200508050030.BIJ05555.PtJGMVOLSFSYFMOtN@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Fri, 5 Aug 2005 00:31:10 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Matt.

> I had a note from you that this was a configuration error on your
> server's part, not on the list.  So I stopped worrying about it...
Oh, really? I'm sorry.

What is funny is that ...

The mail from Matt had a X-OUTRCPT-TO header
with 2 mail addresses (my address and this ml's address),
but the mail from Jesper didn't have the X-OUTRCPT-TO header,
although both mails are sent as a reply to my mail.

The X-OUTRCPT-TO: header in a Linux-kernel-daily-digest Digest
contains 80 mail addresses including my address.

I can find X-OUTRCPT-TO header only in mails from
Matt and Linux-kernel-daily-digest Digest.

You say this is a configuration error on my server's part.
I thought this X-OUTRCPT-TO header is added at linux.us.dell.com
and delivered to 80 recipients, resulting 80 recipients can see
other 79 addresses.
OK, I'll query to the SAKURA.ne.jp whether they had changed
mail configurations recently.

Thank you very much.
