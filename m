Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSKMTck>; Wed, 13 Nov 2002 14:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSKMTck>; Wed, 13 Nov 2002 14:32:40 -0500
Received: from unthought.net ([212.97.129.24]:16536 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262214AbSKMTcj>;
	Wed, 13 Nov 2002 14:32:39 -0500
Date: Wed, 13 Nov 2002 20:39:30 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Ross Vandegrift <ross@willow.seitz.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       linux-kernel@vger.kernel.org
Subject: Re: repeatable IDE errors when using SMART
Message-ID: <20021113193930.GJ22407@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Ross Vandegrift <ross@willow.seitz.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211121800320.20949-100000@twinlark.arctic.org> <20021113172610.GA20515@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021113172610.GA20515@willow.seitz.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 12:26:10PM -0500, Ross Vandegrift wrote:
> On Tue, Nov 12, 2002 at 06:19:37PM -0800, dean gaudet wrote:
> > any suggestions?
> 
> I've noticed that using smartctl on some of my drives kills them too.  I
> didn't bother investigating much - too scared of losing data.  I kind of
> assumed it was a problem with the drive not the code though, since it
> worked fine on one drive but not the other.
> 
> I have a Maxtor and an IBM; unfortuantely I don't recall which one was
> bokning out on smartctl...
> 
> If it's interesting (and resonably safe) I could do some testing on my
> system.

Do you use Promise controllers?

If so, do you use anything newer than the Ultra33 or Ultra66
controllers?


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
