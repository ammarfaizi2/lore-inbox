Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281173AbRKKXmm>; Sun, 11 Nov 2001 18:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281171AbRKKXmb>; Sun, 11 Nov 2001 18:42:31 -0500
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:54973 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S281170AbRKKXmW>; Sun, 11 Nov 2001 18:42:22 -0500
Date: Mon, 12 Nov 2001 00:39:08 +0100
To: linux-kernel@vger.kernel.org,
        ReiserFS Mailingliste <reiserfs-list@namesys.com>
Cc: bert hubert <ahu@ds9a.nl>
Subject: Re: [reiserfs-list] Re: NFS dropouts with <=2.4.15pre1 + ReiserFS
Message-ID: <20011112003908.J16442@jensbenecke.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ReiserFS Mailingliste <reiserfs-list@namesys.com>,
	bert hubert <ahu@ds9a.nl>
In-Reply-To: <20011111124134.E6421@jensbenecke.de> <20011111130511.A26768@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011111130511.A26768@outpost.ds9a.nl>; from ahu@ds9a.nl on Sun, Nov 11, 2001 at 01:05:11PM +0100
X-FAQ-is-At: http://www.linuxfaq.de/
X-No-Archive: Yes
X-Operating-System: Linux 2.4.15-pre1-jb-gr
From: Jens Benecke <jens@jensbenecke.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 01:05:11PM +0100, bert hubert wrote:
> On Sun, Nov 11, 2001 at 12:41:34PM +0100, Jens Benecke wrote:
> 
> > This seems reproducable with a little effort - so I'd be happy to help
> > debugging this (and the bad performance ;) if anybody tells me where to
> > start. As I said, with 'echo 9 > nfsd_debug' I got megabytes of logs
> > filled with nfsd_dispatch, fh_verify, fh_compose, last message repeated
> > 295 times, etc. but nothing that (for me) pointed to an error
> > situation.
> First advice is to reproduce this without external patches. 

Will do. (as soon as I get a chance)


-- 
Jens Benecke ········ http://www.hitchhikers.de/ - Europas Mitfahrzentrale
   · . ·
· · . · . ·  <-------- verdächtiges weisses Puder
 · . · . .
    · ·
