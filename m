Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290356AbSBKXhh>; Mon, 11 Feb 2002 18:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290595AbSBKXh1>; Mon, 11 Feb 2002 18:37:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43532 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290356AbSBKXhS>;
	Mon, 11 Feb 2002 18:37:18 -0500
Message-ID: <3C6855A2.4721DDD3@mandrakesoft.com>
Date: Mon, 11 Feb 2002 18:37:06 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Luigi Genoni <kernel@Expansa.sns.it>,
        Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        LINUX-KERNEL@vger.kernel.org
Subject: Re: thread_info implementation
In-Reply-To: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it> <1013460534.6784.477.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Mon, 2002-02-11 at 15:42, Luigi Genoni wrote:
> 
> > You are optimist.
> 
> The glass is always half full ;)
> 
> > I could not manage to make my sparc64 boot with 2.5.3+ kernels.
> > Now, Actually my problem is reiserFS on sparc64 (I already posted about
> > this). Let's hope I could run 2.5 on sparc64 soon ;)
> 
> I know Dave Miller merged a lot of SPARC64 code into 2.5.4 (including
> preemptible kernel support for SPARC64!) ... at least it compiles.  I
> suspect no other arches do right now.

That computing hotshot otherwise known as Richard Henderon got alpha axp
going with thread_info, though only in UP so far.  So, i386, sparc64,
and alpha have been hacking into working shape.

	:Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
