Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317470AbSHCFLT>; Sat, 3 Aug 2002 01:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSHCFLT>; Sat, 3 Aug 2002 01:11:19 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:52984 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317470AbSHCFLS>; Sat, 3 Aug 2002 01:11:18 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
Subject: Re: installation of latest kernel on compaq notebook
Date: Sat, 3 Aug 2002 15:09:58 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>
References: <20020803050951.4782.qmail@webmail10.rediffmail.com>
In-Reply-To: <20020803050951.4782.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200208031509.58537.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2002 15:09, Enugala Venkata Ramana wrote:
> Hi ,
> Using the make xconfig. i cannot even select it.
I assume that you can select other options, but not
this particular option (Hint: you could have told me that).

I take it that you didn't look at the options that this
option depends on, and you need to turn on the 
configuration options for CONFIG_EXPERIMENTAL
and possibly CONFIG_NET

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
