Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSJLUkJ>; Sat, 12 Oct 2002 16:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSJLUkJ>; Sat, 12 Oct 2002 16:40:09 -0400
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:19017 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S261367AbSJLUkH>;
	Sat, 12 Oct 2002 16:40:07 -0400
From: <Hell.Surfers@cwctv.net>
To: jw@pegasys.ws, linux-kernel@vger.kernel.org
Date: Sat, 12 Oct 2002 21:45:46 +0100
Subject: Re: The end of embedded Linux?
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1034455546793"
Message-ID: <01c162444200ca2DTVMAIL10@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1034455546793
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

such projects already exist, RULE for instance.

Cheers, Dean.

On 	Wed, 9 Oct 2002 16:49:21 -0700 	jw schultz <jw@pegasys.ws> wrote:

--1034455546793
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Thu, 10 Oct 2002 00:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbSJIXnl>; Wed, 9 Oct 2002 19:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262105AbSJIXnl>; Wed, 9 Oct 2002 19:43:41 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:60944 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262060AbSJIXnk>; Wed, 9 Oct 2002 19:43:40 -0400
Received: from leto.pegasys.ws (leto.pegasys.ws [10.1.1.20])
	by vladimir.pegasys.ws (Mail Transfer Agent) with ESMTP id C88E7DF6A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2002 16:51:46 -0700 (PDT)
Received: from duncan.pegasys.ws (duncan.pegasys.ws [10.1.1.50])
	by leto.pegasys.ws (Mail Transfer Agent) with ESMTP id 045D1189
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2002 16:49:22 -0700 (PDT)
Received: by duncan.pegasys.ws (Postfix on SuSE Linux 8.0 (i386), from userid 1001)
	id A13D64AF3; Wed,  9 Oct 2002 16:49:21 -0700 (PDT)
Date: Wed, 9 Oct 2002 16:49:21 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021009234921.GC14644@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1021009074742.27056A-100000@chaos.analogic.com> <200210091917.g99JHkSP001461@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091917.g99JHkSP001461@darkstar.example.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

On Wed, Oct 09, 2002 at 08:17:45PM +0100, jbradford@dial.pipex.com wrote:
> > 
> > On 9 Oct 2002, Alan Cox wrote:
> > 
> > > On Wed, 2002-10-09 at 08:37, Alexander Kellett wrote: 
> > > > This talk of adeos reminds me of something that i'd
> > > > "dreamed" of a while back. Whats the feasability of
> > > > having a 70kb kernel that barely even provides support 
> > > > for user space apps and is basically just an hardware 
> > > > abstraction layer for "applications" that can be 
> > > > written as kernel modules?
> > > 
> > > Its called FreeDOS,
> > > 
> > 
> > -emm. Maybe he needs just a bit more.
> 
> Minix, maybe?

Now, be realistic.  What he asks here isn't that
farfeteched.  Tell me one other OS that has drivers of the
same quality.  I'll be the first to say (oops, Alan beat me
to it) that a Linux stripped down that much wouldn't be
Linux.

However, it wouldn't be an unreasonable project to create
sort of fork that strips Linux down to the bare minimum
while still keeping the driver API.  I don't say that it can
be done just that it might make a reasonable public project
if enough embedded people wanted such a beast^Winsect.  The
dificulty would be excising/replacing core code without
breaking it, side-porting driver patches, and the periodic
resyncing with Linux so new drivers and driver patches would
still apply.  Painful indeed.

Of course it wouldn't be Linux.  Maybe call it Minux or Minlin.
And give it its own mailing list instead of linux-kernel.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1034455546793--


