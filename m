Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136434AbREEDvp>; Fri, 4 May 2001 23:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136588AbREEDvf>; Fri, 4 May 2001 23:51:35 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:39184 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S136434AbREEDvT>; Fri, 4 May 2001 23:51:19 -0400
Date: Sat, 5 May 2001 15:51:13 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Joseph Carter <knghtbrd@debian.org>
Cc: Aaron Tiensivu <mojomofo@mojomofo.com>, linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
Message-ID: <20010505155113.D29451@metastasis.f00f.org>
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu> <006e01c0d4e9$3c0bd210$0300a8c0@methusela> <20010504172657.B14969@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504172657.B14969@debian.org>; from knghtbrd@debian.org on Fri, May 04, 2001 at 05:26:57PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 05:26:57PM -0700, Joseph Carter wrote:

    I don't see how they figure, but in case there was any doubt I
    have a VIA KT133A/686B board (Abit KT7A) and don't experience
    anything resembling disk corruption unless the box crashes for
    some other reason.  I do seem to be experiencing AGP problems in
    spades, but my disks at least are fine.

I too seem no disk problems whatsoever (nothing really interesting
there, many people do not) but am also seeing AGP problems.

In fact, I had to disable AGP to stop X locking the box hard... yet
agpgart and the video driver (NVidia[1]) both claim to support the
chipset -- does anyone actually have this working?)




  --cw

[1] Yeah, close source, blah blah blah. Right now it works for me,
    and it works _VERY_ well.
