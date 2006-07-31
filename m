Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWGaXZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWGaXZL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWGaXZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:25:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:17258 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030385AbWGaXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:25:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BQGB6nGh+KQTVqKafo9Pd5+tulFtysbfJKDKg95A+wcvX2enqpYkcyt0qtJzQ6RQ/0IjzVlY1AATEjzkaFk5C1Mpput+TP7WSLkPtbkSk7VrtKr2P06TzHd6h9SI9HH832a2kZT0tIvrop3MO6ouvK2mwz2mgZbrCKbCp7qA/jU=
Message-ID: <5c49b0ed0607311625t62420736q8cad927bfaf2210c@mail.gmail.com>
Date: Mon, 31 Jul 2006 16:25:07 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Cc: "Adrian Ulrich" <reiser4@blinkenlights.ch>, matthias.andree@gmx.de,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <200607312208.k6VM82P5012867@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <reiser4@blinkenlights.ch>
	 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
	 <200607312208.k6VM82P5012867@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Adrian Ulrich <reiser4@blinkenlights.ch> wrote:
> > > > Great to see that Sun ships a state-of-the-art Filesystem with
> > > > Solaris... I think linux should do the same...
> > >
> > > This would be worthwhile, if only to be able to futz around in Solaris-made
> > > filesystems.
>
> > s/I think linux should do the same/I think linux should include Reiser4/
> >  ;-)
>
> So ZFS isn't "state-of-the-art"?

maybe reiser4 and ZFS are.  certainly, they optimize for different
behavior though

> [...]
>
> > But i'd rather like to see a Linux version of WAFL :-)
>
> WAFL is for high-turnover filesystems on RAID-5 (and assumes flash memory
> staging areas). Not your run-of-the-mill desktop...

yeah, good thing nobody tries to use linux for high-turnover servers
with RAID.  pish-posh.

> > ZFS didn't really impress me:
> > The Volume-Manager is nice but the Filesystem.. well: It beats UFS
> > .. sometimes ;-)
>
> OK, ext3 + LVM it is then.
>
> > See also: http://spam.workaround.ch/dull/postmark.txt
>
> Interesting.

yeah, i hadn't seen postmark numbers on linux before.  maybe mongo
isn't so biased after all

NATE
