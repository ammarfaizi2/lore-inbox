Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130138AbRAZONR>; Fri, 26 Jan 2001 09:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRAZONG>; Fri, 26 Jan 2001 09:13:06 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:12815 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129818AbRAZOMl>; Fri, 26 Jan 2001 09:12:41 -0500
Date: Fri, 26 Jan 2001 15:11:38 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: James Sutherland <jas88@cam.ac.uk>
Cc: "David S. Miller" <davem@redhat.com>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010126151138.B6331@pcep-jamie.cern.ch>
In-Reply-To: <14961.25754.449497.640325@pizda.ninka.net> <Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.21.0101261351150.11126-100000@red.csi.cam.ac.uk>; from jas88@cam.ac.uk on Fri, Jan 26, 2001 at 01:52:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> I was not suggesting ignoring these. OTOH, there is no reason to treat an
> RST packet as "go away and never ever send traffic to this host again" -
> i.e. trying another TCP connection, this time with ECN disabled, would be
> acceptable.

Using a different source port number, even.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
