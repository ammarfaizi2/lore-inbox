Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRAYUpG>; Thu, 25 Jan 2001 15:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136039AbRAYUo1>; Thu, 25 Jan 2001 15:44:27 -0500
Received: from hermes.mixx.net ([212.84.196.2]:28179 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130927AbRAYUoP>;
	Thu, 25 Jan 2001 15:44:15 -0500
Message-ID: <3A708F8F.17426D2@innominate.de>
Date: Thu, 25 Jan 2001 21:41:51 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
In-Reply-To: <Pine.LNX.4.30.0101182129050.1089-100000@nvws005.nv.london> <004701c081ef$e32dcb90$8501a8c0@gromit>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell wrote:
> Unfortunately, unix allows everything but "/" in filenames. This was
> probably a mistake, as it makes it nearly impossible to augment the
> namespace, but it is the reality.

For some reason totally beyond my comprehension // inside a file name is
taken to be the same as /, but if it wasn't it could be the stream
separator.  *sigh*

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
