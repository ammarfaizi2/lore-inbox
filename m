Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136771AbRECMba>; Thu, 3 May 2001 08:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136774AbRECMbU>; Thu, 3 May 2001 08:31:20 -0400
Received: from enst.enst.fr ([137.194.2.16]:13562 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S136771AbRECMbR>;
	Thu, 3 May 2001 08:31:17 -0400
Date: Thu, 03 May 2001 14:30:29 +0200
From: Fabrice Gautier <gautier@email.enst.fr>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: serial console problems with 2.4.4
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <m166fiq260.fsf@frodo.biederman.org>
In-Reply-To: <20010502201026.CB69.GAUTIER@email.enst.fr> <m166fiq260.fsf@frodo.biederman.org>
Message-Id: <20010503142212.7529.GAUTIER@email.enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03 May 2001 02:15:03 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> 
> I get the impression that something in 2.4.3 fixed CREAD handling, and we
> started noticing the buggy user space.

That's my impression too...

> > > I wish I knew where the breakage actually occured.
> > 
> > Just look at this diff on serial.c between 2.4.2 and 2.4.3:
> 
> If it was a real diff between 2.4.2 and 2.4.3 I would agree, however it looks
> like your attempt to fix 2.4.3. 

Err... Yes sorry, in fact this was a workaround proposed by Kanoj, the 
maintener of serial.c (I think)...

Regards.

-- 
Fabrice Gautier <gautier@email.enstfr>

