Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSELNME>; Sun, 12 May 2002 09:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSELNMD>; Sun, 12 May 2002 09:12:03 -0400
Received: from freesurfmta05.sunrise.ch ([194.230.0.18]:27043 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id <S313120AbSELNMC>; Sun, 12 May 2002 09:12:02 -0400
Message-ID: <3CD0FA8C0010E0A9@freesurfmta05.sunrise.ch> (added by
	    postmaster@freesurf.ch)
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 12 May 2002 15:18:26 +0200
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: IRQ > 15 for Athlon SMP boards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 12:31:09 +0100, Dr. David Alan Gilbert wrote:

>* Hugh (hugh@nospam.com) wrote:
>
>> /proc/pci on my computer reports the following, which is definitely
>> abnormal:
>
>No, it is definitely normal - my happily working dual Athlon also has
>IRQs above 15.  I think this is a consequence of the APICs and stuff on
>newer x86 architectures (?) - but it is nothing to worry about.

Not quite - IRQs > 15 are supported by the PCI spec/bus. I guess the x86 
architecture plays into it too, but it is really a PCI matter.


/Per

regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


