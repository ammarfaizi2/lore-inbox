Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVHNUNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVHNUNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVHNUNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:13:44 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:7723 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932226AbVHNUNn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:13:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IBOpANpp71/ZwLiTy96yIm1mWWWBatedU3QiFVMolu+V3xgwsXJzoEWnDPUXV197qT7WvuaK1Wj4TjEtL7FCMrZFKMj10TgPl6I9jy3P+sODGwGdj7mTmUl2t01s7uupx2oqsCZsT7RXLHctz1uQHWL0zUBdiBXEVEkFlmNe0Yw=
Message-ID: <feed8cdd0508141313297beea7@mail.gmail.com>
Date: Sun, 14 Aug 2005 13:13:42 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Patch] Support UTF-8 scripts
Cc: Jason L Tibbitts III <tibbs@math.uh.edu>,
       =?ISO-8859-1?Q?Martin_v=2E_L=F6wis?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124049592.4918.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <42FDE286.40707@v.loewis.de>
	 <feed8cdd0508130935622387db@mail.gmail.com>
	 <1123958572.11295.7.camel@mindpipe>
	 <ufazmrl9h3u.fsf@epithumia.math.uh.edu>
	 <feed8cdd050814125845fe4e2e@mail.gmail.com>
	 <1124049592.4918.2.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/05, Lee Revell <rlrevell@joe-job.com> wrote:
> I know the alternatives are available.  That doesn't make it any less
> idiotic to use non ASCII characters as operators.  I think it's a very
> slippery slope.  We write code in ASCII, dammit.

Yes you and I might write 99.9% of our code in good'ol **American**
Standard Code for Information Interchange -- however not all the world
is USA. For instance notice the http://de.wikipedia.org/wiki/Umlaut/
in "Löwis"... Seems like lots of Europeans might want a bigger
charset, not to mention Asians, Hindus, and whomever else.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
