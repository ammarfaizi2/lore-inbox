Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131300AbRCKHJl>; Sun, 11 Mar 2001 02:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRCKHJb>; Sun, 11 Mar 2001 02:09:31 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33258 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131300AbRCKHJ3>;
	Sun, 11 Mar 2001 02:09:29 -0500
Message-ID: <3AAB245F.A98004D9@mandrakesoft.com>
Date: Sun, 11 Mar 2001 02:08:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org
Subject: Re: List of recent (2.4.0 to 2.4.2-ac18) CONFIG options needing 
 Configure.help text.
In-Reply-To: <15167.984293552@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sat, 10 Mar 2001 23:03:19 -0700,
> Steven Cole <elenstev@mesatop.com> wrote:
> >With the 2.4.0 kernel, there were 476 CONFIG options which had
> >no help entry in Configure.help.  With 2.4.2-ac18, this number is now 547,
> >which has been kept this low with 54 options getting Configure.help text.
> 
> If any of these CONFIG_ options are always derived (i.e. the user never
> sees them on a config menu) then please add the suffix _DERIVED to such
> options.  They still need to start with CONFIG_ to suit the kernel
> build dependency generator so we cannot change the start of the name.
> Appending _DERIVED will make it obvious that the options require no
> help text.

Yow.  That is very cumbersome.  Can't you just keep a list somewhere,
instead of making such options longer?

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
