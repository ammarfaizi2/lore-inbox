Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSDNNUg>; Sun, 14 Apr 2002 09:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312302AbSDNNUf>; Sun, 14 Apr 2002 09:20:35 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59631
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312296AbSDNNUf>; Sun, 14 Apr 2002 09:20:35 -0400
Date: Sun, 14 Apr 2002 06:22:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: -aa VM updates for 2.4
Message-ID: <20020414132239.GX23513@matchmail.com>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
In-Reply-To: <20020413233906.GB10807@matchmail.com> <3CB8C55F.ECD143F7@zip.com.au> <20020414124046.A2186@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 12:40:46PM +0200, bert hubert wrote:
> On Sat, Apr 13, 2002 at 11:56:26PM +0000, Andrew Morton wrote:
> > Mike Fedyk wrote:
> > > 
> > > Why haven't any of the -aa VM updates gone into 2.5?  Especially after Andrew
> > > Morton has split it up this is surprising...
> > 
> > I don't think there's really any point in doing that.
> 
> Are they going to be in 2.4 anytime soon? And if not, why not? 
> 

Yes, some have alredy gone into 2.4.19-pre5 or pre6.  The large vm patch in
-aa was split up by Andrew Morton (as mentioned earlier in this thread).

Expect the next batch to go in the next 19-pre or more likely 20-pre because
many more people test the released versions than the pre kernels.

Mike
