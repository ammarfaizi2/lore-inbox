Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277092AbRJDFxT>; Thu, 4 Oct 2001 01:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277132AbRJDFxJ>; Thu, 4 Oct 2001 01:53:09 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:63617 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277092AbRJDFw6>; Thu, 4 Oct 2001 01:52:58 -0400
Date: Wed, 3 Oct 2001 23:53:25 -0600
Message-Id: <200110040553.f945rPY00355@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <Pine.GSO.4.21.0110040142270.26177-100000@weyl.math.psu.edu>
In-Reply-To: <9pgsk4$7ep$1@penguin.transmeta.com>
	<Pine.GSO.4.21.0110040142270.26177-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> <nit>
> I _really_ doubt that something does write() on /etc/passwd.  Create a
> file and rename it over the thing - sure, but that's it.
> </nit>

# vi /etc/passwd

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
