Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbRGUQhs>; Sat, 21 Jul 2001 12:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267730AbRGUQhi>; Sat, 21 Jul 2001 12:37:38 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53677 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S267727AbRGUQhc>;
	Sat, 21 Jul 2001 12:37:32 -0400
Message-ID: <3B59AFF7.8061645B@mandrakesoft.com>
Date: Sat, 21 Jul 2001 12:38:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0"
In-Reply-To: <000f01c111ff$73602ce0$c20e9c3e@host1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"peter k." wrote:
> 
> i just installed 2.4.7, now a new process called "ksoftirqd_CPU0" is started
> automatically when booting (by the kernel obviously)? why? what does it do?
> i didnt find any useful information on it in linuxdoc / linux-kernel
> archives

it is used internally, ignore it.

-- 
Jeff Garzik      | "I wouldn't be so judgemental
Building 1024    |  if you weren't such a sick freak."
MandrakeSoft     |             -- goats.com
