Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132592AbRAaRrj>; Wed, 31 Jan 2001 12:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132389AbRAaRr3>; Wed, 31 Jan 2001 12:47:29 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:6673
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132117AbRAaRrU>; Wed, 31 Jan 2001 12:47:20 -0500
Date: Wed, 31 Jan 2001 09:46:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andries.Brouwer@cwi.nl
cc: mlord@pobox.com, ole@linpro.no, linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <UTC200101311643.RAA16328.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.10.10101310936280.14252-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 Andries.Brouwer@cwi.nl wrote:

> Ole Aamot writes:
> 
> 	We experience trouble with the Promise (PDC20265) IDE controller
> 	and seven 75GB IBM disks on a single CPU (Pentium-III) server.
> 
> 	Linux 2.4.1 fails to detect correct geometry for the four last
> 	disks (identified as hde, hdf, hdg, hdh).
> 
> But there is no indication of what the problems could be,
> or what he thinks the geometry should be (and why).
> I see nothing very wrong in the posted data.

We agree Andries, but the enduser wants to see stuff the same.

Cheers,

> Andries
> 
> 
> [Don't forget: (i) geometry does not exist (ii) hdparm is just
> some user program.]
> 

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
