Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317540AbSFEDwX>; Tue, 4 Jun 2002 23:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317541AbSFEDwW>; Tue, 4 Jun 2002 23:52:22 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:2314 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317540AbSFEDwV>;
	Tue, 4 Jun 2002 23:52:21 -0400
Date: Tue, 4 Jun 2002 20:49:45 -0700
From: Greg KH <greg@kroah.com>
To: bvermeul@devel.blackstar.nl
Cc: Adam Trilling <agt10@columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19/20] KDE panel (kicker) not starting up
Message-ID: <20020605034945.GA32577@kroah.com>
In-Reply-To: <Pine.GSO.4.44.0206030918120.21429-100000@watsol.cc.columbia.edu> <Pine.LNX.4.33.0206032033030.569-100000@devel.blackstar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 08 May 2002 02:35:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 08:34:44PM +0200, bvermeul@devel.blackstar.nl wrote:
> On Mon, 3 Jun 2002, Adam Trilling wrote:
> 
> > Make sure you have read and write perms on your home directory.  I had
> > that happen due to a misplaced chown -R once.
> > 
> > This is not a kernel question, however, and probably shouldn't be on this
> > list.
> 
> Everythink works using 2.5.17. So I think this *is* a kernel question.
> I've had the same problem with 2.5.19 (and couldn't get 2.5.18 working 
> properly)

Just to add one more "me too" here, I've seen the same thing here.

2.5.18 worked just fine from what I remember.

greg k-h
