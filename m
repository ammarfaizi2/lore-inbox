Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKWAvt>; Wed, 22 Nov 2000 19:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130671AbQKWAvj>; Wed, 22 Nov 2000 19:51:39 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:1215 "EHLO
        shell.webmaster.com") by vger.kernel.org with ESMTP
        id <S129150AbQKWAvX>; Wed, 22 Nov 2000 19:51:23 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <jamagallon@able.es>, "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: uname
Date: Wed, 22 Nov 2000 16:21:18 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKIEOMMAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20001123010145.A744@werewolf.able.es>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Little question about 'uname'. Does it read data from kernel, /proc or
> get its data from other source ?

	'strace' was made to answer questions like this.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
