Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbQLIWx7>; Sat, 9 Dec 2000 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132341AbQLIWxu>; Sat, 9 Dec 2000 17:53:50 -0500
Received: from slc1188.modem.xmission.com ([166.70.8.172]:27153 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132313AbQLIWxk>; Sat, 9 Dec 2000 17:53:40 -0500
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
In-Reply-To: <3A3066EC.3B657570@timpanogas.org> <E144O4d-0003vd-00@the-village.bc.nu> <20001208113340.B4730@vger.timpanogas.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Dec 2000 15:03:22 -0700
In-Reply-To: "Jeff V. Merkey"'s message of "Fri, 8 Dec 2000 11:33:40 -0700"
Message-ID: <m17l59tfpx.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> writes:

> On Fri, Dec 08, 2000 at 02:00:29PM +0000, Alan Cox wrote:
> > > Agree.  We need to disable it, since folks do not read the docs
> > > (obviously).  Of course, we could leave it on, and I could start
> > > charging money for these tools -- there's little doubt it would be a
> > > lucrative business.  Perhaps this is what I'll do if the numbers of
> > > copies keeps growing.  When it hits > 100 per week, it's taking a lot of
> > > our time to support, so I will have to start charging for it.
> > 
> > I am very firmly against removing something because people do not read
> manuals,
> 
> > what is next fdisk , mkfs ?.
> 
> We should put in a nastier message then.  It WILL DESTROY DATA IRREPARABLY 
> and I've got even more bad news -- because it's in Linux, Microsoft is already
> altering the on-disk structures again, so it's about to be broken in R/O
> mode as well when Whistler comes out.  

Hmm. If this is the case then shouldn't someone point this out.  To the
antitrust lawyers.  You present this as a clear case of deliberately
preventing interoperability between NT and linux.

The generous side of me suggests that they might be trying to fix some
mistakes, or enhance things.  Linux isn't standing still on the fs
format issue either.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
