Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290630AbSBLANb>; Mon, 11 Feb 2002 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290629AbSBLANW>; Mon, 11 Feb 2002 19:13:22 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:19384 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S290627AbSBLANH>; Mon, 11 Feb 2002 19:13:07 -0500
Subject: Re: ALSA patch for 2.5.4
From: Dan Mann <mainlylinux@attbi.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0202111429270.500-100000@pnote.perex-int.cz>
In-Reply-To: <Pine.LNX.4.31.0202111429270.500-100000@pnote.perex-int.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1013472766.19794.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 19:14:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are at least 2 reasons that I can see why Linus probably won't
accept your patch:

	1. It is not an inline text attachment (it is a URL).
	2. It is 79,000 lines long

If you could send the patch in smaller chunks over time, or ask one of
Linus' closer (read Highly Trusted) patch maintainers to apply it to
his/her tree first and get some testing, he might be more inclined to
accept it.

Dan Mann


On Mon, 2002-02-11 at 09:16, Jaroslav Kysela wrote:
> Hello all,
> 
> 	a new ALSA patch for 2.5.4 is available at
> 
> ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-2002-02-11-1-linux-2.5.4.patch.gz
> 
> 	I repeat myself but anyway. We are open to any suggestions and
> ideas for this kernel integration patch. Unfortunately, Linus has not
> approved this directory tree and he is not talking with us at the time.
> It seems that BIO changes are over, but he's probably busy enough to
> ignore our e-mails with co-operation requests.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> SuSE Linux    http://www.suse.com
> ALSA Project  http://www.alsa-project.org
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


