Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289387AbSAJK4K>; Thu, 10 Jan 2002 05:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289388AbSAJK4A>; Thu, 10 Jan 2002 05:56:00 -0500
Received: from dns.logatique.fr ([213.41.101.1]:27122 "HELO
	persephone.dmz.logatique.fr") by vger.kernel.org with SMTP
	id <S289387AbSAJKzq>; Thu, 10 Jan 2002 05:55:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Capricelli <tcaprice@logatique.fr>
To: Keith Owens <kaos@ocs.com.au>, Corey Minyard <minyard@acm.org>
Subject: Re: Moving zlib so that others may use it
Date: Thu, 10 Jan 2002 11:55:05 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <24675.1010641200@kao2.melbourne.sgi.com>
In-Reply-To: <24675.1010641200@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020110105313.3ED7023CBB@persephone.dmz.logatique.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday 10 January 2002 06:40, Keith Owens wrote:
> On Wed, 09 Jan 2002 23:13:28 -0600,
>
> Corey Minyard <minyard@acm.org> wrote:
> >Hmm.  It worked fine for me.  I made it a module, and it put it into
> >kernel/lib in
> >/lib/modules/2.4.17 and it did not put it in lib/lib.a  I make it a
> >non-module, and
> >it gets included in lib/lib.a. My diff was the same as yours for the
> >Makefile.
>
> Worked for me this time as well.  I had a typo the first time then did
> an ugly fix to a non-existent problem :(


	Could you give a patch for all of this ? either Keith or Corey ?


Thomas

