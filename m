Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278454AbRJVJiL>; Mon, 22 Oct 2001 05:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278451AbRJVJiB>; Mon, 22 Oct 2001 05:38:01 -0400
Received: from tilmax2.tatainfotech.com ([203.124.134.178]:36358 "EHLO
	tilmax2.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S278449AbRJVJhu>; Mon, 22 Oct 2001 05:37:50 -0400
Message-ID: <3BD3E8EE.8EEB4AF3@tatainfotech.com>
Date: Mon, 22 Oct 2001 15:07:50 +0530
From: Sunil Phatak <sunil.phatak@tatainfotech.com>
Organization: Tata Infotech Ltd.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Abraham vd Merwe <abraham@2d3d.co.za>
CC: Tim Jansen <tim@tjansen.de>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: LPP (was: The new X-Kernel !)
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu> <15vQtM-22TOdsC@fmrl02.sul.t-online.com> <20011022022839.A8452@unthought.net> <15va3i-0cRXvcC@fmrl00.sul.t-online.com> <20011022103411.A17996@crystal.2d3d.co.za>
Content-Type: multipart/mixed;
 boundary="------------9D600DC4FE75A9A35B4FA727"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------9D600DC4FE75A9A35B4FA727
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Abraham vd Merwe wrote:

> Hi Tim!
>
> > > How would hiding that information make the system "easier to use" ?
> >
> > Because the majority of people (and especially those who haven't been reached
> > by Linux yet) don't care for the messages. They are as interested in boot
> > messages as you may be in reading debug information from your DVD player or
> > car.

Well, people and even novices may be interested in the boot messages and/or can
learn a great deal from them.  But at boot time the messages can be hidden as they
anyway scroll past too fast to read, and are available later by 'dmesg'. Even the
init log is available for anyone to read. It would be nicer if the messages were
displayed on if a critical error occurred.

> I suspect most people on this list feel the same as me and also feel that
> kernel debugging messages is not only a feature, but essential!

The 'startup screen+ progress bar' can be enabled for all stable kernels once
Linus freezes that version.

> See the difference between the O/S in question and the one you might be
> confusing it with is that this O/S was (and still is) written and being
> maintained by technical people. These kind of people like to know what's
> going on. It also happens that the primary audience for these people's work
> is themselves (us) and NOT novices - that my friend, is a bonus, not the
> sole aim of the exercise.

Not really! The developers might be 'technical people' (as expected for an OS),
but the users are most definitely an audience worth caring for and most of them
are unaware of even the simplest of OS fundamentals.


--------------9D600DC4FE75A9A35B4FA727
Content-Type: text/x-vcard; charset=us-ascii;
 name="sunil.phatak.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Sunil Phatak
Content-Disposition: attachment;
 filename="sunil.phatak.vcf"

begin:vcard
n:Phatak;Sunil
tel;home:0832-255918
x-mozilla-html:FALSE
org:Tata Infotech Ltd.;Embedded Technology Group
version:2.1
email;internet:sunil.phatak@tatainfotech.com
title:Associate Systems Engineer
adr;quoted-printable:;;B-4, Shalini Niwas,=0D=0AAnsabhat;Mapusa;Goa;403507;India
x-mozilla-cpt:;14208
fn:Sunil Phatak
end:vcard

--------------9D600DC4FE75A9A35B4FA727--

