Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRDJRft>; Tue, 10 Apr 2001 13:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDJRfj>; Tue, 10 Apr 2001 13:35:39 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:4615 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129638AbRDJRf2>;
	Tue, 10 Apr 2001 13:35:28 -0400
Date: Tue, 10 Apr 2001 19:35:21 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410193521.A21133@pcep-jamie.cern.ch>
In-Reply-To: <20010410191528.B21024@pcep-jamie.cern.ch> <E14n1vV-0004gX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14n1vV-0004gX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 06:27:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Games would like to be able to page flip at vertical refresh time --
> > <1ms accuracy please.  Network traffic shaping benefits from better than
> 
> This is an X issue. I was talking with Jim Gettys about what is needed to
> get the relevant existing X extensions for this working

Last time I looked at XF86DGA (years ago), it seemed to have the right
hooks in place.  Just a matter of server implementation.  My
recollection is dusty though.

-- Jamie
