Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272643AbRIGNWG>; Fri, 7 Sep 2001 09:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272644AbRIGNV4>; Fri, 7 Sep 2001 09:21:56 -0400
Received: from [195.89.159.99] ([195.89.159.99]:13301 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272643AbRIGNVx>; Fri, 7 Sep 2001 09:21:53 -0400
Date: Fri, 7 Sep 2001 02:53:36 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: kubla@sciobyte.de, joe@mathewson.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Message-ID: <20010907025336.D7329@kushida.degree2.com>
In-Reply-To: <200109061246.HAA61789@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109061246.HAA61789@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Sep 06, 2001 at 07:46:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> > Kerberos won't help either - The only parts of NFS that were kerberized
> > was the initial mount. Everything else uses filehandles/UDP. Encryption
> > doesn't help either - slows the entire network down too much.
> 
> I disagree! First of all you can always use NFS over TCP, so much for
> "every thing else uses filehandles/UDP". (No that this improves security,
> but it can improve reliability!)

It can improve security if you use NFS over TCP over SSL...

That may be easier to configure than IPSec in some environments.

-- Jamie
