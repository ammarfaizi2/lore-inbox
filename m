Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278685AbRKMUG4>; Tue, 13 Nov 2001 15:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRKMUGr>; Tue, 13 Nov 2001 15:06:47 -0500
Received: from freeside.toyota.com ([63.87.74.7]:5387 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S278685AbRKMUGm>; Tue, 13 Nov 2001 15:06:42 -0500
Message-ID: <3BF17D49.1E721BC1@lexus.com>
Date: Tue, 13 Nov 2001 12:06:33 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: kees@schoen.nl, jjs@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: report: tun device
In-Reply-To: <3BF0EE24.7661D843@pobox.com>
		<Pine.LNX.4.33.0111131138001.16924-100000@schoen3.schoen.nl> <20011113.024514.130620001.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

>    From: kees <kees@schoen.nl>
>    Date: Tue, 13 Nov 2001 11:38:32 +0100 (CET)
>
>    No I downloaded 2.4.14 and applied patch-2.4.15.pre3
>
> I think he's referring to the tun userland utilities version, not the
> kernel version.  There is a required tun utility upgrade, if I
> remember.

Both actually - there was a change around
kernel 2.4.6 IIRC that required a new version
of vtund (2.5b1) - so if vtund was working in
e.g.  a vanilla RH 7.1 install, and he upgraded
to 2.4.14, vtund would be broken and he'd
have to upgrade to the latest version.

cu

jjs

