Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261301AbREVLMq>; Tue, 22 May 2001 07:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261317AbREVLM0>; Tue, 22 May 2001 07:12:26 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:28938 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S261301AbREVLMV>; Tue, 22 May 2001 07:12:21 -0400
Date: Tue, 22 May 2001 23:12:18 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010522231218.C10207@metastasis.f00f.org>
In-Reply-To: <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521115631.I30738@athlon.random> <15112.59880.127047.315855@pizda.ninka.net> <15112.60362.447922.780857@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.60362.447922.780857@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 03:19:54AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 03:19:54AM -0700, David S. Miller wrote:

    Electrically (someone correct me, I'm probably wrong) PCI is
    limited to 6 physical plug-in slots I believe, let's say it's 8
    to choose an arbitrary larger number to be safe.

Minor nit... it can in fact be higher than this, but typically it is
not. CompactPCI implementations may go higher (different electrical
characteristics allow for this).



  --cw
