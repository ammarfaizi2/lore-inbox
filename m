Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135412AbRAYM17>; Thu, 25 Jan 2001 07:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135442AbRAYM1t>; Thu, 25 Jan 2001 07:27:49 -0500
Received: from p3EE3C7D3.dip.t-dialin.net ([62.227.199.211]:14606 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135412AbRAYM1k>; Thu, 25 Jan 2001 07:27:40 -0500
Date: Thu, 25 Jan 2001 13:27:32 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010125132732.A3804@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010125115827.A1483@emma1.emma.line.org> <Pine.SOL.4.21.0101251216070.651-100000@orange.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.21.0101251216070.651-100000@orange.csi.cam.ac.uk>; from jas88@cam.ac.uk on Thu, Jan 25, 2001 at 12:17:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, James Sutherland wrote:

> This isn't a violation - the section quoted does not REQUIRE the
> behaviour, it only RECOMMENDS it as being a good idea. Since implementing
> it apparently makes DoS attacks easier, NOT implementing it is now a
> better idea...

Ok, now for the interoperability. Is there a problem with this when the
recommendation is not followed?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
