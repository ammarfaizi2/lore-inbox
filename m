Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbQLEL3c>; Tue, 5 Dec 2000 06:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbQLEL3X>; Tue, 5 Dec 2000 06:29:23 -0500
Received: from p3EE3C888.dip.t-dialin.net ([62.227.200.136]:39684 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131110AbQLEL3I>; Tue, 5 Dec 2000 06:29:08 -0500
Date: Tue, 5 Dec 2000 11:17:27 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH - documentation for ll_rw_block and generic_make_request
Message-ID: <20001205111727.A4278@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <14890.58098.787542.75516@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14890.58098.787542.75516@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Mon, Dec 04, 2000 at 11:18:58 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2000, Neil Brown wrote:

>  Would you accept such as patch at this stage?

The patch seems to use too long a line length, is it possible to
reformat this with a right margin of 80 for the benefit of those who use
text-mode terminals to hack?

While I can't comment on the content, any documentation enhancements are
certainly welcome, thank you! :-)

> + *    allow the device driver to select requests off that queue when it is ready.
> + *    This works well for many block devices. However some block devices (typically

(Two samples of long lines).

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
