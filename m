Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQKJTRg>; Fri, 10 Nov 2000 14:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQKJTR0>; Fri, 10 Nov 2000 14:17:26 -0500
Received: from ryouko.dgim.crc.ca ([142.92.39.75]:60043 "EHLO
	ryouko.dgim.crc.ca") by vger.kernel.org with ESMTP
	id <S129741AbQKJTRV>; Fri, 10 Nov 2000 14:17:21 -0500
Date: Fri, 10 Nov 2000 14:15:57 -0500 (EST)
From: "William F. Maton" <wmaton@ryouko.dgim.crc.ca>
Reply-To: wmaton@ryouko.dgim.crc.ca
To: Richard A Nelson <cowboy@vnet.ibm.com>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in   /var/spool/mqueue]
In-Reply-To: <Pine.LNX.4.30.0011101405490.19584-100000@back40.badlands.lexington.ibm.com>
Message-ID: <Pine.GSO.3.96LJ1.1b7.1001110141514.27803C-100000@ryouko.dgim.crc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Richard A Nelson wrote:

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

You anticipated what I was about to type :-)
 
> I've not seen any problems, save a documented case with *one* third
> party SMTP server (don't recall who it was).

No problems here either...

> 
> -- 
> Rick Nelson
> Old MacLinus had a stack/l-i-n-u-x/and on this stack he had a trace/l-i-n-u-x
> with an Oops-Oops here and an Oops-Oops there
> here an Oops, there an Oops, everywhere an Oops-Oops.
> 	-- tjimenez@site.gmu.edu, linux.dev.kernel
> 



wfms

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
