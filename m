Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130695AbRAZWbu>; Fri, 26 Jan 2001 17:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131303AbRAZWbk>; Fri, 26 Jan 2001 17:31:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39952 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130695AbRAZWbb>; Fri, 26 Jan 2001 17:31:31 -0500
Message-ID: <3A71FAA0.B6DE6E1A@transmeta.com>
Date: Fri, 26 Jan 2001 14:30:56 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Dominik Kubla <dominik.kubla@uni-mainz.de>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Lars Marowsky-Bree <lmb@suse.de>, James Sutherland <jas88@cam.ac.uk>,
        "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <20010126124426.O2360@marowsky-bree.de> <Pine.SOL.4.21.0101261344120.11126-100000@red.csi.cam.ac.uk> <20010126154447.L3849@marowsky-bree.de> <20010126160342.B7096@pcep-jamie.cern.ch> <20010126161616.A21435@uni-mainz.de> <20010126162707.E7096@pcep-jamie.cern.ch> <20010126232640.B25603@uni-mainz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla wrote:
> 
> On Fri, Jan 26, 2001 at 04:27:07PM +0100, Jamie Lokier wrote:
> ...
> > Yeah, Apache and Samba establish _outgoing_ connections with fixed
> > source ports.... Not!
> 
> Oops! Of course. Brain-damage on my part.  Now where is that dammned
> brown paper bag...
> 

ftpd and sshd do, however.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
