Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTDQSEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTDQSEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:04:48 -0400
Received: from tag.witbe.net ([81.88.96.48]:40454 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261868AbTDQSEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:04:47 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Mads Christensen'" <mfc@krycek.org>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: cannot boot 2.5.67
Date: Thu, 17 Apr 2003 20:16:42 +0200
Message-ID: <01b401c3050d$7f441d70$6400a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <1050601594.1073.1.camel@krycek>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> You have to get 
> CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y
> inorder for you to see anything =)
Yes, I guess I have that, as I'm using the .config from a 2.5.66
that was booting quite fine...

Anyhow, you are right, maybe that moving .config from a release to
another one is not 100% safe...

Regards,
Paul

