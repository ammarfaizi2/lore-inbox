Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbSIPOc6>; Mon, 16 Sep 2002 10:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261998AbSIPOc6>; Mon, 16 Sep 2002 10:32:58 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:40185 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S261997AbSIPOc5>; Mon, 16 Sep 2002 10:32:57 -0400
Message-Id: <200209161437.g8GEbp2f288692@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 05:37:44 -0400
X-Mailer: KMail [version 1.3.1]
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <200209160236.g8G2a6Qn022070@pimout3-ext.prodigy.net> <20020916095004.3ae2b901.spyro@f2s.com>
In-Reply-To: <20020916095004.3ae2b901.spyro@f2s.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 04:50 am, Ian Molton wrote:
> On Sun, 15 Sep 2002 17:35:59 -0400
>
> Rob Landley <landley@trommello.org> wrote:
> > I think we agree.  So why recommend against debuggers if they save
> > time and effort while producing patches of equal quality?
>
> I think the point here is that debuggers are not for everyone. They are
> a tool, in much the same way as an adjustable wrench is. I prefer a set
> of spanners.
>
> Is there anything wrong with NOT wanting to use a debugger? really?

I don't want to use reiserfs.  I'm not lobbying to keep it out of the kernel 
for the significant number of people who do want it.

It's Linus's final call, and now we can fake 95% of the same functionality by 
attaching userspace debuggers to UML, so...

Rob
