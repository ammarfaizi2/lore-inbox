Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264536AbRFOVuc>; Fri, 15 Jun 2001 17:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbRFOVuN>; Fri, 15 Jun 2001 17:50:13 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:11431 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264536AbRFOVuB>; Fri, 15 Jun 2001 17:50:01 -0400
Message-ID: <3B2A8404.168D6E1D@earthlink.net>
Date: Fri, 15 Jun 2001 16:54:12 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: EEPRO100/S support
In-Reply-To: <3B2A76A8.9F79082F@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hey all,
> I just had an eepro/100 S delivered to me.  I haven't dug through specs
> yet, but has anyone looke at this?  Supposedly has a 3DES ASIC built in to
> the core.
>
> Any way we can use it?

Good question.  I've been wondering how exactly that ASIC would even benefit
Windows users.

Should 3DES functions be moved to the kernel?  Anything's possible.  Then get
with the libcrypt people to get the 3DES acceleration supported transparently
in glibc.

FWIW, I believe Intel's Linux drivers will support this card under 2.4, and I
believe (not 100% certain on this) that they're GPL.  I'll have to check on
that.

Kelledin

