Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTDJBX2 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 21:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTDJBX2 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 21:23:28 -0400
Received: from pop.gmx.de ([213.165.65.60]:4744 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263979AbTDJBX1 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 21:23:27 -0400
From: "Oliver S." <Follow.Me@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: WG: questions regarding Journalling-FSes and w-cache reordering
Date: Thu, 10 Apr 2003 03:35:09 +0200
Message-ID: <001801c2ff01$6c5e6150$0200000a@kimba>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hehe
> I would argue that we can schedule I/O much better than any 
> OS can,

 But if the OS can rely on a linear mapping the scheduling isn't
significantly worse than when handled by the HD.

