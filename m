Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291762AbSBNR23>; Thu, 14 Feb 2002 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291798AbSBNR2U>; Thu, 14 Feb 2002 12:28:20 -0500
Received: from mail.scs.ch ([212.254.229.5]:43955 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S291762AbSBNR2E>;
	Thu, 14 Feb 2002 12:28:04 -0500
Message-ID: <3C6BF39B.FFF2C8BF@scs.ch>
Date: Thu, 14 Feb 2002 18:27:55 +0100
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-21jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] es1370 fix
In-Reply-To: <20020214161730.A8112@bytesex.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> 
>   Hi,
> 
> This patch fixes the es1370 driver (the virt_to_bus thing).

Bugbuf could be shared among all cards in the system...
Otherwise looks correct

Tom
