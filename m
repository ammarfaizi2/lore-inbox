Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263419AbRFEXYv>; Tue, 5 Jun 2001 19:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbRFEXYl>; Tue, 5 Jun 2001 19:24:41 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:61959 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S263419AbRFEXYW>; Tue, 5 Jun 2001 19:24:22 -0400
Date: Wed, 6 Jun 2001 11:24:20 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "David S. Miller" <davem@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, bjornw@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
Message-ID: <20010606112419.A24800@metastasis.f00f.org>
In-Reply-To: <15132.22933.859130.119059@pizda.ninka.net> <13942.991696607@redhat.com> <3B1C1872.8D8F1529@mandrakesoft.com> <15132.15829.322534.88410@pizda.ninka.net> <20010605155550.C22741@metastasis.f00f.org> <25587.991730769@redhat.com> <15132.40298.80954.434805@pizda.ninka.net> <20010605190128.A12204@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010605190128.A12204@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Tue, Jun 05, 2001 at 07:01:28PM +0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 07:01:28PM +0200, Jamie Lokier wrote:

    Whether this works depends on the cache line replacement policy. 
    It will always work with LRU, for example, and probably
    everything else that exists.  But it is not guaranteed, is it?

Getting way OT here... didn't the K6 or something have the ability to
lock cache lines?


  --cw
