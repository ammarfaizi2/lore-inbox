Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270654AbRHJV5p>; Fri, 10 Aug 2001 17:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270655AbRHJV5f>; Fri, 10 Aug 2001 17:57:35 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:12935 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S270654AbRHJV5X>; Fri, 10 Aug 2001 17:57:23 -0400
Message-Id: <200108102157.f7ALvHh29091@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Date: Fri, 10 Aug 2001 17:57:34 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <20010810231906.A21435@bonzo.nirvana>
In-Reply-To: <20010810231906.A21435@bonzo.nirvana>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been awhile since I had this problem, but I recall
	shutdown -r -n now
doing the job.

	-- Brian

On Friday 10 August 2001 05:19 pm, Axel Thimm wrote:
> How can I reboot a stuck machine remotely, when there are
> uninterruptable processes arround? shutdown -r, reboot [-n] [-f],
> telinit 6 do not give the intended results. Localy I can use
> Alt-SysRq-S/U/B, but what if I still have a remote ssh connection and
> don't want to have to get to the machines location?
>
> Of course the real problem are the processes themselves, but being able
> to revive a machine is also nice ;)
>
> Regards, Axel.
