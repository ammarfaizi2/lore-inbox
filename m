Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280812AbRKGPMR>; Wed, 7 Nov 2001 10:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRKGPMI>; Wed, 7 Nov 2001 10:12:08 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:34551 "HELO
	pobox.com") by vger.kernel.org with SMTP id <S280812AbRKGPLv>;
	Wed, 7 Nov 2001 10:11:51 -0500
Subject: Re: kernel 2.4.14 compiling fail for loop device
To: troy@holstein.com
Date: Wed, 7 Nov 2001 07:12:04 -0800 (PST)
Cc: mhaque@haque.net, rml@tech9.net, mfedyk@matchmail.com, jimmy@mtc.dhs.org,
        linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <no.id> from "Todd M. Roy" at Nov 07, 2001 07:13:07 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011107151204.7E53389816@pobox.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I did, and used a looped an iso image, eventually my
> computer froze up.  Using the actual cd, it did not.  So my
> personal answer would be no.

Hmmm... my *root* filesystem (with /usr, /home, etc. all on it) on one of
my computers is loop mounted, and I've not had such a freeze with 2.4.14
and the two lines removed... Just another data point.

-Barry K. Nathan <barryn@pobox.com>
