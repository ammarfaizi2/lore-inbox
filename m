Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVBRT0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVBRT0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 14:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVBRT0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 14:26:22 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:1031 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVBRT0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 14:26:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UeZrmy4snhLBf63h1PgVvS9Z16M56GFx46f2BJWkD+YuZXB7AvKiTgBv/EBGx4qc5rSf7Ve8G9G3Zy+YzlTCpeBAsrf18T68Ci8edTXqOCuBM4YsL1VP3Axb5KZx65h0Go1VUDY9B9gsDmz2cIW5RSWFue7OJxQDVUcxWjVLc2I=
Message-ID: <d120d50005021811263c40f683@mail.gmail.com>
Date: Fri, 18 Feb 2005 14:26:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Sean <seanlkml@sympatico.ca>
Subject: Re: [BK] upgrade will be needed
Cc: "Theodore Ts'o" <tytso@mit.edu>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <4075.10.10.10.24.1108751663.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <seanlkml@sympatico.ca>
	 <4912.10.10.10.24.1108675441.squirrel@linux1>
	 <200502180142.j1I1gJXC007648@laptop11.inf.utfsm.cl>
	 <1451.10.10.10.24.1108713140.squirrel@linux1>
	 <20050218162729.GA5839@thunk.org>
	 <4075.10.10.10.24.1108751663.squirrel@linux1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 13:34:23 -0500 (EST), Sean <seanlkml@sympatico.ca> wrote:
> On Fri, February 18, 2005 11:27 am, Theodore Ts'o said:
> 
> > If you truly believe that BK would be able to add the value that it
> > does to the kernel development process by using some other SCM as the
> > master SCM, with BK being "underneath", as you proposed earlier, then
> > you do not understand why BK is fundamentally better than the current
> > open source SCM systems that are out there.
> 
> BK already feeds patches out at the head, surely if it's as powerful as
> you think, it could feed a free SCM too for your non-bk friends in the
> community.

What is bk2cvs gateway that is maintained by Larry then? Just call it
your "head" that Linus feeds from his BK repository and you are all
set.

I can see  that Roman and Stellian want something different, but we
alerady have what you have just described.

-- 
Dmitry
