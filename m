Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318914AbSH1TWO>; Wed, 28 Aug 2002 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318915AbSH1TWO>; Wed, 28 Aug 2002 15:22:14 -0400
Received: from mailb.telia.com ([194.22.194.6]:41980 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S318914AbSH1TWN>;
	Wed, 28 Aug 2002 15:22:13 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Joachim Breuer <jmbreuer@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: PDC20262 IDE - DMA no go?
Date: Wed, 28 Aug 2002 21:25:15 +0200
User-Agent: KMail/1.4.6
References: <m31y8iooai.fsf@terra.fo.et.local>
In-Reply-To: <m31y8iooai.fsf@terra.fo.et.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200208282125.15241.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 20.01, Joachim Breuer wrote:
> D. I think the fs is hosed, format it and restore from backup. Next
> fsck shows it has errors. Correct them. Just to be on the safe side,
> reboot and fsck again. Guess what. So it seems that in this
> configuration an fsck under 2.4.19-rc1-ac2 would corrupt the fs it's
> trying to fix.
> 

After reading this I have to ask.
You are not trying to fsck a mounted partion are you?

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

