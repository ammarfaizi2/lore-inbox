Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRHaTns>; Fri, 31 Aug 2001 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHaTni>; Fri, 31 Aug 2001 15:43:38 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:21959 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S268963AbRHaTn2>; Fri, 31 Aug 2001 15:43:28 -0400
Message-ID: <3B8FE8F0.A8072B7A@bigfoot.com>
Date: Fri, 31 Aug 2001 12:43:44 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <20010831044247.B811@gondor.com> <3B8EFF67.9010409@digitalaudioresources.org> <3B8FD501.CE027082@bigfoot.com> <3B8FE2D1.A0AD0B04@mail.utexas.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bobby D. Bryant" wrote:
> 
> Tim Moore wrote:
> 
> > > It seems to work somewhat better for some if you set your BIOS to the
> > > conservative settings, but that didn't help me.  I have an Epox 8KTA3+ (Via
> > > KT133A) w/ a 1.4GHz Athlon and 512MB memory.  If you can't get it to work that
> > > way, just stick with the K6 setting.  The point is, your hardware is likely fine
> > > (fine being relative, I suppose)
> > > If there are other tricks, I'm all ears.
> >
> > The i686 setting works perfectly.
> 
> For some people.  I have an 8KTA3+ that will boot as an i686, but starts oopsing its
> shorts off after it has been up a while.
> 
> I posted some of the oopsen a few months ago, and to my feeble mind they all looked
> memory related.  (Several were "bug in slab.c" kind of thing, IIRC.

I hadn't heard a case of 686 not working given the compatability between
Athlon/PIII.  To be clear, CONFIG_M686=y has worked perfectly with
850MHz Athlon + VT82C686.

rgds,
tim.
--
