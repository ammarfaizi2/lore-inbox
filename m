Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262650AbREVQ5O>; Tue, 22 May 2001 12:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbREVQ5E>; Tue, 22 May 2001 12:57:04 -0400
Received: from tempest.blackhat.net ([216.140.158.10]:12038 "EHLO
	tempest2.blackhat.net") by vger.kernel.org with ESMTP
	id <S262650AbREVQ4s>; Tue, 22 May 2001 12:56:48 -0400
Date: Tue, 22 May 2001 11:55:59 -0500
From: Joe Barr <warthawg@blackhat.net>
To: David Relson <relson@osagesoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Final Warning [ was: ECN is on! ]
Message-Id: <20010522115559.1f4b5aa8.warthawg@blackhat.net>
In-Reply-To: <4.3.2.7.2.20010522105643.00d1d380@mail.osagesoftware.com>
In-Reply-To: <20010522131031.C5947@mea-ext.zmailer.org>
	<15114.18990.597124.656559@pizda.ninka.net>
	<4.3.2.7.2.20010522105643.00d1d380@mail.osagesoftware.com>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i686-pc-linux-gnu)
Organization: Linux Liberation Army
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



What is ECN?  Is it the reason SNORT has started this lately:

<snip>

Active System Attack Alerts
=-=-=-=-=-=-=-=-=-=-=-=-=-=
May 22 10:11:18 pooh snort: spp_portscan: PORTSCAN DETECTED from 199.183.24.194 (STEALTH)
May 22 10:11:22 pooh snort: spp_portscan: portscan status from 199.183.24.194: 1 connections across 1 hosts: TCP(1), UDP(0) STEALTH

</snip>

See ya,
Joe Barr




On Tue, 22 May 2001 10:57:34 -0400




David Relson <relson@osagesoftware.com> wrote:

> At 10:18 AM 5/22/01, Steve Modica wrote:
> 
> 
> >Perhaps it's none of my business, but it doesn't seem very sporting to
> >just turn something on that breaks stuff and say "you had fair
> >warning".  Why not shut it back off, issue a statement saying it works
> >now and will be re-enabled on June 10th or something, and everyone must
> >do thus and so or they will break on that day?
> >
> >Vague things like "it'll be turned on real soon now" or ASAP really mean
> >"never" since admins always have things with real deadlines at the top
> >of their list.
> 
> 
> I'd suggest something like:
> 
> Final Warning.  ECN is being turned on NOW.  If your firewall doesn't 
> support ECN, this will be the last message that gets through to you from us.
> 
> Such a message will have the interesting characteristic of being the last 
> message received.  This will make it obvious why no further messages are 
> arriving.
> 
> David
> 
> --------------------------------------------------------
> David Relson                   Osage Software Systems, Inc.
> relson@osagesoftware.com       Ann Arbor, MI 48103
> www.osagesoftware.com          tel:  734.821.8800
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 

#--------------------------------------------------#
| Joe Barr                   warthawg@blackhat.net |
| Longears and Linux........... nowhere but Texas! |
#--------------------------------------------------#
