Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLRPwR>; Mon, 18 Dec 2000 10:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbQLRPwH>; Mon, 18 Dec 2000 10:52:07 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:27017 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129325AbQLRPvy>; Mon, 18 Dec 2000 10:51:54 -0500
From: Christoph Rohland <cr@sap.com>
To: Janne Himanka <janne.himanka@sonera.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with SYSV IPC
In-Reply-To: <m3bsv937qr.fsf@kyklos.poh.tele.fi>
Organisation: SAP LinuxLab
Date: 18 Dec 2000 16:21:20 +0100
In-Reply-To: Janne Himanka's message of "21 Nov 2000 13:05:48 +0200"
Message-ID: <qwwvgshdabz.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janne,

On 21 Nov 2000, Janne Himanka wrote:
> I have compiled 2.4.0-test10 and 2.4.0-test11 kernels, mounted
> /dev/shm and tried to install the Perl IPC::Shareable module. "make
> test" produces a lot of errors (sample below), and a message from
> the kernel appears in /var/log/messages. I am using a Compaq PIII
> 866MHz, Redhat 7.0. I compiled test10 with gcc 2.96 anf kgcc, test11
> with kgcc, all produced more or less the same results. SYSV IPC is
> configured in the kernel. No modules were loaded at the time of
> failure. After the failure the machine functions normally.  X
> apparently uses shared memory without problems. I attach also the
> ksymoops output.

Could you test this on 2.4.0-test13-pre3?

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
