Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbSJHNAs>; Tue, 8 Oct 2002 09:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263005AbSJHNAs>; Tue, 8 Oct 2002 09:00:48 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:6481 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S263012AbSJHNAq>;
	Tue, 8 Oct 2002 09:00:46 -0400
From: <Hell.Surfers@cwctv.net>
To: jlnance@intrex.net, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 14:06:02 +0100
Subject: RE:Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034082362856"
Message-ID: <00e3723041308a2DTVMAIL7@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034082362856
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

sounds good, could a space wiper be made for secret agencies/buisness throwing away old hdds?

Cheers, Dean.

On 	Tue, 8 Oct 2002 08:49:48 -0400 	jlnance@intrex.net wrote:

--1034082362856
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Tue, 8 Oct 2002 13:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262311AbSJHMoI>; Tue, 8 Oct 2002 08:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262343AbSJHMoI>; Tue, 8 Oct 2002 08:44:08 -0400
Received: from smtp.intrex.net ([209.42.192.250]:10 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S262311AbSJHMoG>;
	Tue, 8 Oct 2002 08:44:06 -0400
Received: from tricia.dyndns.org [216.181.42.97] by intrex.net with ESMTP
  (SMTPD32-5.05) id A49B223D007C; Tue, 08 Oct 2002 08:50:35 -0400
Received: by tricia.dyndns.org (Postfix, from userid 227)
	id 9984A4AB92; Tue,  8 Oct 2002 08:49:48 -0400 (EDT)
Date: Tue, 8 Oct 2002 08:49:48 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-ID: <20021008124948.GA1572@tricia.dyndns.org>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com> <20021008023654.GA29076@netnation.com> <3DA247F3.B1150369@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA247F3.B1150369@digeo.com>
User-Agent: Mutt/1.4i
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Mon, Oct 07, 2002 at 07:50:27PM -0700, Andrew Morton wrote:

> I have the core code for ext3.  It's at
> http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.19-pre10/ext3-reloc-page.patch
> I never tested it, but that's a formality ;)
> 
> It offers a simple ioctl to reloate a single page's worth of blocks.
> It's fully journalled and recoverable, pagecache coherent, etc.
> But the userspace application which calls that ioctl hasn't been
> written.

Hi Andrew,
    I decided not to let the fact that I have never written any FS code
stand in the way of making suggestions :-) :-)
    Do you think it would be better to make the defragmentation part of
the normal operation of the FS rather than a seperate application.  For
example, if you did a fragmentation check/fix on the last close of a file
you would know that coherency issues were not going to be important.  It
might also give you some way to determine which files were important to
keep close together.

Thanks,

Jim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034082362856--


