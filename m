Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135934AbRARWmS>; Thu, 18 Jan 2001 17:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135947AbRARWmI>; Thu, 18 Jan 2001 17:42:08 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:55290 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S135934AbRARWl4>; Thu, 18 Jan 2001 17:41:56 -0500
Date: Thu, 18 Jan 2001 16:41:55 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <005801c0819e$6c5c0640$067039c3@cintasverdes>
In-Reply-To: <001c01c08199$387205f0$067039c3@cintasverdes> <20010118161000.A3487@mediaone.net>
Subject: Re: ERR in /proc/interrupts
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010118224205Z135934-403+1634@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Jorge Boncompte \(DTI2\)" <jorge@dti2.net> on Thu, 18
Jan 2001 23:31:38 +0100


> Are IPI related to SMP machines? This is not an SMP machine nor kernel.

Yes, Inter-Process Interrupts are an SMP thing.  I know you need to have an SMP
kernel for IPI's to be issued, but I don't know if you actually need to have
more than one processor.

Obviously, someone here is confused.  I just hope it's not me!


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
