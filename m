Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbREROBF>; Fri, 18 May 2001 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbREROAz>; Fri, 18 May 2001 10:00:55 -0400
Received: from hermes.sistina.com ([208.210.145.141]:19472 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S262322AbREROAm>;
	Fri, 18 May 2001 10:00:42 -0400
Date: Fri, 18 May 2001 15:57:32 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Mauelshagen@Sistina.com, Thomas Kotzian <thomasko321k@gmx.at>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010518155732.A26161@sistina.com>
Reply-To: Mauelshagen@Sistina.com
In-Reply-To: <20010516185845.A14397@sistina.com> <200105170635.f4H6Ztq456282@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200105170635.f4H6Ztq456282@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, May 17, 2001 at 02:35:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2001 at 02:35:55AM -0400, Albert D. Cahalan wrote:
> Heinz J. Mauelshag writes:
> 
> > LVM does a similar thing storing UUIDs in its private metadata
> > area on every device used by it.
> >
> > Problem is: neither MD nor LVM define a standard in Linux
> > which *needs* to be used on every device!
> >
> > It is just up to the user to configure devices with them or not.
> >
> > BTW: in case we had a Linux standard it wouldn't solve the
> > "different OS" situation mentioned in this thread either.
> >
> >
> > Generally speaking:
> > 
> > It is not the problem to reserve some space to store a uuid or
> > something at such and such location on a device.
> >
> > The problem is the lack of a standard which eventually
> > could be implemented in all OSes at some point in time.
> 
> The PC partition table has such an ID. The LILO change log
> mentions it. I think it's 6 random bytes, with some restriction
> about being non-zero.

This is just a type identifier showing the parition type and just
valid on the PC.

Won't help it.

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
