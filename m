Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290664AbSBLA5m>; Mon, 11 Feb 2002 19:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290662AbSBLA5c>; Mon, 11 Feb 2002 19:57:32 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:57615 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290659AbSBLA5N>; Mon, 11 Feb 2002 19:57:13 -0500
Message-ID: <3C68685F.90C3AAA4@linux-m68k.org>
Date: Tue, 12 Feb 2002 01:57:03 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <3C6832CC.D9D27F2F@linux-m68k.org>
		<20020211205048.GA5401@krispykreme> <20020211.164617.39155905.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"David S. Miller" wrote:

> I was able to blow away all of the assembler offset stuff because now
> all the stuff assembly wants to get at is in one structure and it is
> trivial to compute the offsets by hand.

Where's the problem to compute them automatically?

bye, Roman
