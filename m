Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131518AbQKJTJ0>; Fri, 10 Nov 2000 14:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131491AbQKJTJQ>; Fri, 10 Nov 2000 14:09:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:25297 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S130575AbQKJTJF>; Fri, 10 Nov 2000 14:09:05 -0500
Date: Fri, 10 Nov 2000 14:08:44 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: <wmaton@ryouko.dgim.crc.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in  
 /var/spool/mqueue]
In-Reply-To: <3A0C43D0.14039937@timpanogas.org>
Message-ID: <Pine.LNX.4.30.0011101405490.19584-100000@back40.badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Jeff V. Merkey wrote:

> "William F. Maton" wrote:
> >
> > What about sendmail 8.11.1?  Is the problem there too?
>
> Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
> encryption.

Eh?!? TLS is an optional, negotiated protocol started *after* the two
sendmails are communicating.

I've not seen any problems, save a documented case with *one* third
party SMTP server (don't recall who it was).

-- 
Rick Nelson
Old MacLinus had a stack/l-i-n-u-x/and on this stack he had a trace/l-i-n-u-x
with an Oops-Oops here and an Oops-Oops there
here an Oops, there an Oops, everywhere an Oops-Oops.
	-- tjimenez@site.gmu.edu, linux.dev.kernel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
