Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTCEOmV>; Wed, 5 Mar 2003 09:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTCEOmU>; Wed, 5 Mar 2003 09:42:20 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:13778 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S267137AbTCEOmQ>; Wed, 5 Mar 2003 09:42:16 -0500
To: bert hubert <ahu@ds9a.nl>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
References: <1046863752.441.7.camel@simulacron>
	<20030305112852.GA22351@outpost.ds9a.nl>
From: Derek Atkins <warlord@MIT.EDU>
Date: 05 Mar 2003 09:52:44 -0500
In-Reply-To: <20030305112852.GA22351@outpost.ds9a.nl>
Message-ID: <sjm1y1lyif7.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> writes:

> On Wed, Mar 05, 2003 at 12:29:12PM +0100, Andreas Jellinghaus wrote:
> > Hi,
> > 
> > both manual keying and automatic keying with racoon (pre-shared secret)
> > are working fine. No need to patch or modify anything. 
> > I tried only ipv4.
> 
> By the way, regarding ipsec-tools 0.1, are you sure you want to fork the
> projects involved?

I spoke to the KAME people and unfortunately, at least for now, there
is no other choice but to fork.  Perhaps down the road we can merge,
but as of last week they don't want to host a linux package.  They are
willing to take some of our patches, but that doesn't help with a
build system.

> By the way, you did not mention it here but ipsec-tools is available on
> http://sourceforge.net/projects/ipsec-tools , I also link them from
> http://lartc.org/howto/lartc.ipsec.html

I didn't?   Perhaps I said ipsec-tool.sourceforge.net which has a
link to sourceforge.net/projects/ipsec-tools and is much shorter
to type. ;) 

> Regards,
> 
> bert

-derek

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
