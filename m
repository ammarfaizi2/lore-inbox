Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbRAZW37>; Fri, 26 Jan 2001 17:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbRAZW3t>; Fri, 26 Jan 2001 17:29:49 -0500
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:47333 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S130473AbRAZW3k>; Fri, 26 Jan 2001 17:29:40 -0500
Date: Fri, 26 Jan 2001 23:26:40 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Lars Marowsky-Bree <lmb@suse.de>, James Sutherland <jas88@cam.ac.uk>,
        "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126232640.B25603@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	Lars Marowsky-Bree <lmb@suse.de>,
	James Sutherland <jas88@cam.ac.uk>,
	"David S. Miller" <davem@redhat.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch> <20010126161616.A21435@uni-mainz.de> <20010126162707.E7096@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010126162707.E7096@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Fri, Jan 26, 2001 at 04:27:07PM +0100
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 04:27:07PM +0100, Jamie Lokier wrote:
...
> Yeah, Apache and Samba establish _outgoing_ connections with fixed
> source ports.... Not!

Oops! Of course. Brain-damage on my part.  Now where is that dammned
brown paper bag...

Dominik
-- 
          A lovely thing to see:                   Kobayashi Issa
     through the paper window's holes               (1763-1828)
                the galaxy.               [taken from: David Brin - Sundiver]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
