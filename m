Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRBYN6A>; Sun, 25 Feb 2001 08:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBYN5v>; Sun, 25 Feb 2001 08:57:51 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:64269 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129199AbRBYN5l>; Sun, 25 Feb 2001 08:57:41 -0500
Date: Mon, 26 Feb 2001 02:57:36 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: netdev@oss.sgi.com,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New net features for added performance
Message-ID: <20010226025736.A13227@metastasis.f00f.org>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <3A986EDB.363639E7@coplanar.net> <20010225162357.A12123@metastasis.f00f.org> <20010225134156.K18271@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010225134156.K18271@almesberger.net>; from Werner.Almesberger@epfl.ch on Sun, Feb 25, 2001 at 01:41:56PM +0100
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 01:41:56PM +0100, Werner Almesberger wrote:

    Well, you'd have to re-design the networking code to support NUMA
    architectures, with a fairly fine granularity. I'm not sure you'd
    gain anything except possibly for the forwarding fast path.

I'm not convince for a general purpose OS you would gain anything at
all; but an an intellectual exercise it's a fascinating idea.

I'd make a good PhD thesis.



  --cw
