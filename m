Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287513AbSA1XOd>; Mon, 28 Jan 2002 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSA1XOZ>; Mon, 28 Jan 2002 18:14:25 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:63620 "EHLO
	theirongiant.zip.net.au") by vger.kernel.org with ESMTP
	id <S287513AbSA1XOI>; Mon, 28 Jan 2002 18:14:08 -0500
Date: Tue, 29 Jan 2002 10:13:09 +1100
From: CaT <cat@zip.com.au>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: Re: [swsusp] swsusp for 2.4.17 -- newer ide supported
Message-ID: <20020128231309.GD655@zip.com.au>
In-Reply-To: <20020128100704.GA3013@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020128100704.GA3013@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 11:07:05AM +0100, Pavel Machek wrote:
> Hi!
> 
> This is newer version of swsusp patch. It now supports newer ide
> driver (which just about everybody uses). It sometimes fails to
> suspend when top is running, otherwise no bugs are known. Try to break
> this one!
> 								Pavel

Having just (accidentally :) found out that my laptop does not survive 3
days on suspend to ram I gotta ask... Will this version work with ext3?
If so then I can try and break it. I just don't wanna use something that
is known to be rude to filesystems. I like my data. :)

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."
      -- http://www.azcentral.com/offbeat/articles/1129soccer29-ON.html
