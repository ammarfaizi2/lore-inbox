Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281559AbRKZKZb>; Mon, 26 Nov 2001 05:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281561AbRKZKZW>; Mon, 26 Nov 2001 05:25:22 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:2830 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S281559AbRKZKZL>; Mon, 26 Nov 2001 05:25:11 -0500
Message-ID: <3C021848.A25B284A@idb.hist.no>
Date: Mon, 26 Nov 2001 11:24:08 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer in 2.4.15pre1 still not 100% ok
In-Reply-To: <01112217224700.01298@manta> <E166wVS-0004Vk-00@localhost> <01112313001401.00886@manta>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> Maybe I misunderstand something, but why OOM chose top? Is it how it is
> intended to work?

It is intended to do the least possible damage when killing
something.  I'd say it does nicely when killing "top", you
surely don't loose much work that way. :-)

Helge Hafting
