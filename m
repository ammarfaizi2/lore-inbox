Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312246AbSCRIVG>; Mon, 18 Mar 2002 03:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312248AbSCRIUu>; Mon, 18 Mar 2002 03:20:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312243AbSCRIU1>;
	Mon, 18 Mar 2002 03:20:27 -0500
Date: Mon, 18 Mar 2002 08:20:26 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Joel Becker <jlbec@evilplan.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020318082026.X4836@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <3C945D7D.8040703@mandrakesoft.com> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk> <20020318080531.W4836@parcelfarce.linux.theplanet.co.uk> <3C95A0DB.40008@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 03:10:03AM -0500, Jeff Garzik wrote:
> to be fair, fcntl(2) could be used in conjunction with open(2), to do 
> dynamic hints.

	I wasn't speaking to the exact interface, just to the real world
usefulness of hints after open(2).  But yes, surely :-)

Joel


-- 

"Baby, even the losers
 Get luck sometimes.
 Even the losers
 Keep a little bit of pride."

			http://www.jlbec.org/
			jlbec@evilplan.org
