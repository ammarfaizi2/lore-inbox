Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282954AbRK0VB6>; Tue, 27 Nov 2001 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282951AbRK0VBn>; Tue, 27 Nov 2001 16:01:43 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:16142 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S282953AbRK0VB3>;
	Tue, 27 Nov 2001 16:01:29 -0500
Subject: Re: Problems with APM suspend and ext3
From: Shaya Potter <spotter@cs.columbia.edu>
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Andrew Morton <akpm@zip.com.au>, Kamil Iskra <kamil@science.uva.nl>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C03F85B.ACF072D4@oracle.com>
In-Reply-To: <Pine.LNX.4.33.0111270958320.3391-100000@krakow.science.uva.nl>
	<3C03CEFB.780622F1@zip.com.au>  <3C03F85B.ACF072D4@oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 16:00:53 -0500
Message-Id: <1006894862.873.8.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 15:32, Alessandro Suardi wrote:
> Andrew Morton wrote:
> > 
> > Kamil,
> > 
> > thank you for the clear and convincing problem description.
> > 
> > It's becoming increasingly clear that we need to do something with
> > ext3 and laptops.
> 
> My Dell Latitude CPx J750GT running RH7.2 and all-ext3 (except
>  for my Oracle 9012 database partition) suspends just fine by
>  hitting Fn-Suspend without doing anything special. Has been
>  working forever and moving to ext3 (built in kernel) hasn't
>  changed anything. Resume also works fine - recent log:

as does my ThinkPad T-21.  calling apm --suspend works fine.  Though for
some reason if I leave it on all night (not suspended) I wake up to a
frozen laptop.  Not exactly sure why, perhaps ext3 related, not exactly
sure how to investigate.

shaya

