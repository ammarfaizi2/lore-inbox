Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAITBo>; Tue, 9 Jan 2001 14:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbRAITBf>; Tue, 9 Jan 2001 14:01:35 -0500
Received: from raven.toyota.com ([63.87.74.200]:7950 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S129764AbRAITB0>;
	Tue, 9 Jan 2001 14:01:26 -0500
Message-ID: <3A5B5FF3.BFBF6AD1@toyota.com>
Date: Tue, 09 Jan 2001 11:01:07 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ll i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Silviu Marin-Caea <silviu@delrom.ro>
CC: linux-kernel@vger.kernel.org, rlug@lug.ro
Subject: Re: Failure building 2.4 while running 2.4.  Success in building 2.4 
 while running 2.2.
In-Reply-To: <20010109111247.397581ea.silviu@delrom.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Silviu Marin-Caea wrote:

> I have RedHat7, glibc-2.2-9, gcc-2.96-69.
>
> I can build 2.4.0 while running kernel 2.2.16.
>
> If I try to rebuild 2.4.0 while running the new kernel, I get random
> compiler errors.

Could you supply the text of the errors, and your .config?

I've been building 2.4.0 kernels on Red Hat 7
with no problems on the following systems -

- Celeron 600
- AMD K6-2 450
- Quad Pentium Pro

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
