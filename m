Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313319AbSDOWak>; Mon, 15 Apr 2002 18:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313321AbSDOWaj>; Mon, 15 Apr 2002 18:30:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17933 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313319AbSDOWaj>; Mon, 15 Apr 2002 18:30:39 -0400
Subject: Re: link() security
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 15 Apr 2002 23:48:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a9f9f7$cng$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 15, 2002 12:25:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xFGx-0007As-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not to mention the fact that the single file mailbox design is itself
> flawed.  Mailboxes are fundamentally directories, which news server
> authors quickly realized.

And then unrealized when they hit performance limitations. Its a trade off
and one that most news systems seem to prefer to use a custom database
for
