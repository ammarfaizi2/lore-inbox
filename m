Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWFOJkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWFOJkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWFOJkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:40:45 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:28876 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932293AbWFOJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:40:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=se/PpVRSQeUM9IFS1DHIN30npuo/u0Z0hajZB3fGP5l8WEBfZEAoNFTIv8gLP7BoLjWKiTEB31UPe4r3YKXg3zBp/jDzZvHuPjF2MrfjjO+6gLT7uzpTY/z667MF24GZD5+uXc64Pwx3tu1e7/KXGuYE0aJDU0xHBUkakuD9MDg=
Message-ID: <986ed62e0606150240t6f96b2baya52b9f0515da2e47@mail.gmail.com>
Date: Thu, 15 Jun 2006 02:40:43 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Matthew Frost" <artusemrys@sbcglobal.net>,
       "Alex Tomas" <alex@clusterfs.com>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060615091539.GF9423@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m3irnacohp.fsf@bzzz.home.net> <m3ac8mcnye.fsf@bzzz.home.net>
	 <4489B83E.9090104@sbcglobal.net>
	 <20060609181426.GC5964@schatzie.adilger.int>
	 <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz>
	 <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com>
	 <20060614213431.GF4950@ucw.cz>
	 <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
	 <20060615091539.GF9423@elf.ucw.cz>
X-Google-Sender-Auth: 836925300e5847aa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/06, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
>
> > >Passes 8 hours of me trying to intentionally break it with weird,
> > >artifical disk corruption.
> > >
> > >I even have script somewhere.
> >
> > Ok, thanks for clarifying.
>
> You can get a copy, it would be interesting to know how JFS/XFS does.

Ok, I would be interested in getting a copy. (Maybe it would be good
to post it in public so that other people can try it too.)
-- 
-Barry K. Nathan <barryn@pobox.com>
