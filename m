Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbTCZNty>; Wed, 26 Mar 2003 08:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261699AbTCZNty>; Wed, 26 Mar 2003 08:49:54 -0500
Received: from mango.tao-group.com ([62.255.240.131]:33806 "EHLO
	mail.tao-group.com") by vger.kernel.org with ESMTP
	id <S261697AbTCZNtw>; Wed, 26 Mar 2003 08:49:52 -0500
Subject: Re: Reproducible terrible interactivity since 2.5.64bk2
From: Andrew Ebling <aebling@tao-group.com>
To: Michal Schmidt <schmidt@kn.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E81945C.4010102@kn.vutbr.cz>
References: <3E81945C.4010102@kn.vutbr.cz>
Content-Type: text/plain
Organization: Tao Group
Message-Id: <1048687681.6345.13.camel@spinel.tao.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 26 Mar 2003 14:08:01 +0000
Content-Transfer-Encoding: 7bit
Comment: Checked by Tao OGEMP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 11:51, Michal Schmidt wrote:

> I'm seeing serious interactivity problems in 2.5.65, 2.5.66, 2.5.65-mm4 
> and 2.5.64-bk2.
> I couldn't reproduce it on 2.5.64, 2.5.64-bk1.

I'm seeing similar on 2.5.66; xmms pauses when doing disk intensive
tasks.

> I use Debian Woody on UP Athlon 800MHz, Asus A7V, 384MB RAM, disk WDC 
> WD800JB-00CRA1 connected to on-board Promise 20265, nVidia Geforce2 MX, 
> Realtek RTL-8139C, SB Live.
> GCC is 2.95.4.

My system details: Gentoo Linux 1.2, PIII 1Ghz, 256MB RAM, Ati Rage128,
tulip nic, es1371 based sound card, gcc 2.95.3.

I'd be prepared to test any proposed fixes.

thanks,

Andy

The contents of this e-mail and any attachments are confidential and may
be legally privileged. If you have received this e-mail and you are not
a named addressee, please inform us as soon as possible on
+44 118 901 2999 and then delete the e-mail from your system. If you are
not a named addressee you must not copy, use, disclose, distribute,
print or rely on this e-mail. Any views expressed in this e-mail or any
attachments may not necessarily reflect those of Tao's management.
Although we routinely screen for viruses, addressees should scan this
e-mail and any attachments for viruses. Tao makes no representation or
warranty as to the absence of viruses in this e-mail or any attachments.
Please note that for the protection of our business, we may monitor and
read e-mails sent to and from our server(s).
