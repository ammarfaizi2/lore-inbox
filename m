Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbTCKIg4>; Tue, 11 Mar 2003 03:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbTCKIg4>; Tue, 11 Mar 2003 03:36:56 -0500
Received: from unthought.net ([212.97.129.24]:4258 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262862AbTCKIgz>;
	Tue, 11 Mar 2003 03:36:55 -0500
Date: Tue, 11 Mar 2003 09:47:36 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Matthew Wilcox <willy@debian.org>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Daniel Phillips <phillips@arcor.de>, John Bradford <john@grabjohn.com>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       tytso@mit.edu, adilger@clusterfs.com, chrisl@vmware.com,
       bzzz@tmi.comex.ru
Subject: Re: [Ext2-devel] Re: [RFC] Improved inode number allocation for HTree
Message-ID: <20030311084736.GE14814@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Matthew Wilcox <willy@debian.org>,
	Bryan O'Sullivan <bos@serpentine.com>,
	Daniel Phillips <phillips@arcor.de>,
	John Bradford <john@grabjohn.com>, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger@clusterfs.com,
	chrisl@vmware.com, bzzz@tmi.comex.ru
References: <200303102104.h2AL43iZ000875@81-2-122-30.bradfords.org.uk> <20030310212953.57F2310435B@mx12.arcor-online.net> <1047332834.11339.3.camel@serpentine.internal.keyresearch.com> <20030310220254.GA21234@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030310220254.GA21234@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 10:02:54PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 10, 2003 at 01:47:14PM -0800, Bryan O'Sullivan wrote:
> > Why start?  Who actually uses atime for anything at all, other than the
> > tiny number of shops that care about moving untouched files to tertiary
> > storage?
> > 
> > Surely if you want to heap someone else's plate with work, you should
> > offer a reason why :-)
> 
> "You have new mail" vs "You have mail".

And having a clean /tmp using tmpwatch.  Everything in my /tmp not
accessed for a few weeks gets deleted.  I move cruft to /tmp every
single day, and I have not cleaned it up for years. It just stays tidy
all by itself.  Of course one has to remember this when leavning a few
database files there before taking a vacation   ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
