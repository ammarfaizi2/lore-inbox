Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131749AbQLNK0c>; Thu, 14 Dec 2000 05:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132065AbQLNK0W>; Thu, 14 Dec 2000 05:26:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5904 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131749AbQLNK0R>; Thu, 14 Dec 2000 05:26:17 -0500
Subject: Re: VM problems still in 2.2.18
To: mark@symonds.net (Mark Symonds)
Date: Thu, 14 Dec 2000 09:57:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <079301c06576$b303f060$0301a8c0@symonds.net> from "Mark Symonds" at Dec 13, 2000 06:36:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146V8k-00043W-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bug was discovered.  Ever since, I have two boxes here
> that keep falling over.  Box A will randomly lock without 
> warning and box B will die and start printing this message 
> repeatedly on the screen until I physically hit reset:

What are these two boxes doing ?

> Is there a patch out there that I can apply to 2.2.14
> against the security bug?  The machines were very stable
> on that kernel.

Andrea's VM-global patch seems to be a wonder cure for those who have tried
it. Give it a shot and let folks know.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
