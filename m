Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264279AbRFLI5X>; Tue, 12 Jun 2001 04:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264280AbRFLI5D>; Tue, 12 Jun 2001 04:57:03 -0400
Received: from [203.192.192.176] ([203.192.192.176]:47364 "EHLO
	voodoo.pinkpoodles.com") by vger.kernel.org with ESMTP
	id <S264279AbRFLI45>; Tue, 12 Jun 2001 04:56:57 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hrishi <hrishi@mediaibc.com>
Organization: mediaibc.com
To: Boenisch Joerg <joerg.boenisch@siemens.at>, linux-kernel@vger.kernel.org
Subject: Re: AVM A1 pcmcia, kernel 2.4.5-ac11 problem
Date: Tue, 12 Jun 2001 14:48:59 +0530
X-Mailer: KMail [version 1.2]
In-Reply-To: <D9F2B9CD7BD5D21196BC0800060D9ED604ED6344@vies186a.sie.siemens.at>
In-Reply-To: <D9F2B9CD7BD5D21196BC0800060D9ED604ED6344@vies186a.sie.siemens.at>
X-Dookie-is: myfavalbum
MIME-Version: 1.0
Message-Id: <01061214485901.23960@voodoo>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tuesday 12 June 2001 14:07, Boenisch Joerg wrote:
> I hope not to be off topic! (In that case could you tell me where to ask?)
me too :)
>
<snip>
> cardmgr[1070]: + modprobe: Can´t locate module avma1_cs
> cardmgr[1070]: modprobe exited with status 255
> cardmgr[1070]: module /lib/modules/2.4.5-ac11/pcmcia/avma1_cs.o not
> available
modprobe cannot find the file avma1_cs.o. it may not exist at all (check your 
.config ), or the specified path (in /etc/modules.conf) may be wrong.
if neither of these apply to your system, it may be a misconfiguration in 
/etc/modules.conf or a hardware problem.
i cannot help you with pcmcia however. never used it.

cheers,
Hrishi
