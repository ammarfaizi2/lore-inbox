Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSFEPHQ>; Wed, 5 Jun 2002 11:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSFEPHQ>; Wed, 5 Jun 2002 11:07:16 -0400
Received: from [213.196.40.44] ([213.196.40.44]:27865 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S315454AbSFEPGG>;
	Wed, 5 Jun 2002 11:06:06 -0400
Date: Wed, 5 Jun 2002 15:39:08 +0200 (CEST)
From: <bvermeul@devel.blackstar.nl>
To: Dave Jones <davej@suse.de>
cc: Greg KH <greg@kroah.com>, Adam Trilling <agt10@columbia.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19/20] KDE panel (kicker) not starting up
In-Reply-To: <20020605120638.D5277@suse.de>
Message-ID: <Pine.LNX.4.33.0206051537490.17164-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Dave Jones wrote:

> On Tue, Jun 04, 2002 at 08:49:45PM -0700, Greg KH wrote:
>  > > Everythink works using 2.5.17. So I think this *is* a kernel question.
>  > > I've had the same problem with 2.5.19 (and couldn't get 2.5.18 working 
>  > > properly)
>  > 
>  > Just to add one more "me too" here, I've seen the same thing here.
>  > 2.5.18 worked just fine from what I remember.
> 
> Wasn't this attributed to the /proc/meminfo format changing ?

If it is, that doesn't explain why when using KDE as root everything works 
perfectly. That (at least in my eyes) can't be explained by a change in 
format in /proc/meminfo. I could be wrong of course.

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

