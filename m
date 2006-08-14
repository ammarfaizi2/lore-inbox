Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWHNPlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWHNPlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWHNPlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:41:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:37835 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750832AbWHNPla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:41:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqKypJc30vj8+QvPMy9kHiqpAyya8iOuixDn/pt8KJ1qVyzjRGoVn9g/GdLcz3awvwFSrO7YQxFvKDeU9TJwS9gDSfzldrOWb4I/SVmRlXm1MFCl5YCiFwxsM/b1PQqPFz0E4l7xxFQrJYsmdiwo/rMIxciFTM7DWQ4vL80G0p4=
Message-ID: <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:41:29 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: Touchpad problems with latest kernels
Cc: "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060814152000.GA19065@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <200608141038.04746.gene.heskett@verizon.net>
	 <20060814152000.GA19065@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> On Mon, Aug 14, 2006 at 10:38:04AM -0400, Gene Heskett wrote:
> > I don't *think* I'm a lunatic, but I'm equally sure that the synaptics is a
> > pain in the ass and should be capable of being totally disabled somehow,
> > hopefully short of opening the lappy up and unplugging or cutting every
> > lead to it until such time as it can be made to behave instead of
> > responding to every thumb waved 1/2 to 3/4" above it.  I've gotten hand
> > cramps trying to hold my thumbs far enough away from that abomination to
> > stop such goings on.
> >
> > So count this as a vote FOR doing something about the synaptics touchpad
> > situation.
>
> I'm seeing issues as well on my Dell Inspiron 8000 (yes, it has a Synaptics,
> NOT ALPS as usual on Inspiron):
>
> (without a mouse plugged in) after random times the pointer exhibits
> clear signs of craziness, moving on its own (mild issue) or jumping
> uncontrollably (worse) or being completely off-screen most of the time
> (worst).
>
> IIRC (I'm quite sure about this) the very first time that I've seen
> this phenomenon happen on my notebook was around 2.6.9,
> and I attributed this to broken/grown-old hardware on my notebook
> (thus from then on mostly running with external mouse attached),
> but since several people now report very similar issues
> one would think that it's a driver calibration or touchpad setup issue
> instead of actually broken touchpad hardware.
>
> Plus, I'm sometimes having issues with pointer movement (cursor won't advance
> any more unless I stop touching the touchpad for a few seconds to let it
> reset somehow - probably a bytestream hickup issue).
>
> Any clues?
>

Yes, you might want to reseat your touchpad connector and vacuum the
case a bit. Inspiron 8000 is almost the same as 8100 and I am using it
constantly ;) Well, I thought my keyboard broke because PgUp stopped
working but it recovered after I got a hairball from under the key.
Just make sure you do not pull ACPI battery info to often.

-- 
Dmitry
