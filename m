Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317275AbSFGLsv>; Fri, 7 Jun 2002 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317274AbSFGLsv>; Fri, 7 Jun 2002 07:48:51 -0400
Received: from h0060083874bc.ne.client2.attbi.com ([24.128.158.52]:63107 "HELO
	ladyluck.clue4all.net") by vger.kernel.org with SMTP
	id <S317273AbSFGLsu>; Fri, 7 Jun 2002 07:48:50 -0400
Date: Fri, 7 Jun 2002 07:48:58 -0400
From: "Brian J.Conway" <bconway@wpi.edu>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra100 hang
Message-Id: <20020607074858.41ea925f.bconway@wpi.edu>
In-Reply-To: <Pine.LNX.4.44.0206070245570.8609-100000@sjoerd.sjoerdnet>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2002 02:51:44 +0200 (CEST)
Arjan Filius <iafilius@xs4all.nl> wrote:

> Hello Alan,
> 
> 
> On 6 Jun 2002, Alan Cox wrote:
> 
> > On Thu, 2002-06-06 at 19:53, Arjan Filius wrote:
> > > Hello Brian,
> > >
> > > Same issue here, 2.4.18 running fine with my new 160GB maxtor drive
> > > on a promise udma100 ide controller, 2.4.19-pre9 hangs on partition
> > > check at boot time.
> >
> > Should be ok in pre10-ac2. I'll push Marcelo the change soon
> 
> pre10-ac2 runs fine (promise udma100 issue).
> 
> Thanks for the reponse.

I reverted to a fresh 2.4.18 after installing and everything runs fine,
I'll give 2.4.19-rc1 a try when it's released and rebuild my system in the
meantime.  Thanks for all the help.

-b
