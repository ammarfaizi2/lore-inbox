Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbQKJTOq>; Fri, 10 Nov 2000 14:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQKJTO1>; Fri, 10 Nov 2000 14:14:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2574 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131478AbQKJTOP>; Fri, 10 Nov 2000 14:14:15 -0500
Message-ID: <3A0C4816.F07F8700@timpanogas.org>
Date: Fri, 10 Nov 2000 12:10:14 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard A Nelson <cowboy@vnet.ibm.com>
CC: wmaton@ryouko.dgim.crc.ca, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  
 /var/spool/mqueue]
In-Reply-To: <Pine.LNX.4.30.0011101405490.19584-100000@back40.badlands.lexington.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Send me an email from it with an attachment > 1MB, and I will forward
back to you when (and if) It gets delivered before next week.

:-)

Jeff

Richard A Nelson wrote:
> 
> On Fri, 10 Nov 2000, Jeff V. Merkey wrote:
> 
> > "William F. Maton" wrote:
> > >
> > > What about sendmail 8.11.1?  Is the problem there too?
> >
> > Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
> > encryption.
> 
> Eh?!? TLS is an optional, negotiated protocol started *after* the two
> sendmails are communicating.
> 
> I've not seen any problems, save a documented case with *one* third
> party SMTP server (don't recall who it was).
> 
> --
> Rick Nelson
> Old MacLinus had a stack/l-i-n-u-x/and on this stack he had a trace/l-i-n-u-x
> with an Oops-Oops here and an Oops-Oops there
> here an Oops, there an Oops, everywhere an Oops-Oops.
>         -- tjimenez@site.gmu.edu, linux.dev.kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
