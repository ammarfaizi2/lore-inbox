Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTEGSrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264177AbTEGSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:47:52 -0400
Received: from mail.skjellin.no ([80.239.42.67]:2697 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S263204AbTEGSrw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:47:52 -0400
From: "Andre Tomt" <andre@tomt.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.21-rc1 "breaks" older procps
Date: Wed, 7 May 2003 21:02:32 +0200
Message-ID: <000e01c314cb$36b82420$0a01ff0a@slurv>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <000d01c314c9$4afb96d0$0a01ff0a@slurv>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my great tradition on replying to my own posts, here's another one.

> The IDE changes that went into 2.4.21-pre seems to make older 
> procps unhappy, at least the one in Debian 3.0r1 (latest 
> stable). Upgrading to a newer procps seems to fix this, but 
> is this breakage really needed? "Breaking" stable debian 
> userland is not very nice :-)

I forgot to mention what procps version I was using, it is 2.0.7 debian
patchlevel 9.

-- 
Cheers,
André Tomt

