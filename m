Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143532AbRA1Q6V>; Sun, 28 Jan 2001 11:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143568AbRA1Q6L>; Sun, 28 Jan 2001 11:58:11 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:23784 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S143532AbRA1Q6B>; Sun, 28 Jan 2001 11:58:01 -0500
Message-ID: <3A746512.74CE13D4@home.com>
Date: Sun, 28 Jan 2001 13:29:38 -0500
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: mike <lazybrain@rcn.com>
CC: Linux-Kernel@vger.kernel.org
Subject: Re: doesn't boot.
In-Reply-To: <3A744BD0.332CBBAD@rcn.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike wrote:
> 
> Hi,  im not sure if im emailing the right place but its  a start. I just
> setup kernel 2.4.0 and well it doesnt boot.
> 
> it says " ok booting the kernel" then nothing happens on the screen, and
> I hear no activity from the computer. I tried it several times following
> the
> instructions, I did make mrproper, etc, tired putting the source in a
> different dir, etc. I remember to reinstall lilo, all the good stuff. Im
> not sure whats wrong.
> 
> My system is 2 466 celerons, abtit bp6 , 128ram, voodoo 3 3000,  maxtor
> hd, all custom built. Anyone have any ideas? thanks in advance.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

When you configured the kernel, did you remember to change the processor
type to "Pentium Pro/Celeron/Pentium II"?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
