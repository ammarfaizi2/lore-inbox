Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272753AbRIGQJ0>; Fri, 7 Sep 2001 12:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272754AbRIGQJN>; Fri, 7 Sep 2001 12:09:13 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:26822 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S272753AbRIGQJB>; Fri, 7 Sep 2001 12:09:01 -0400
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: wnoise
From: wnoise@ugcs.caltech.edu (Aaron Denney)
Newsgroups: mlist.linux.kernel
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Date: 7 Sep 2001 15:41:40 GMT
Organization: California Institute of Technology, Pasadena
Message-ID: <slrn9phqlj.69t.wnoise@barter.ugcs.caltech.edu>
In-Reply-To: <linux.kernel.20010907025336.D7329@kushida.degree2.com>
Reply-To: wnoise@ugcs.caltech.edu
NNTP-Posting-Host: barter.ugcs.caltech.edu
User-Agent: slrn/0.9.6.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> wrote:
> Jesse Pollard wrote:
> > > Kerberos won't help either - The only parts of NFS that were kerberized
> > > was the initial mount. Everything else uses filehandles/UDP. Encryption
> > > doesn't help either - slows the entire network down too much.
> > 
> > I disagree! First of all you can always use NFS over TCP, so much for
> > "every thing else uses filehandles/UDP". (No that this improves security,
> > but it can improve reliability!)
> 
> It can improve security if you use NFS over TCP over SSL...
> 
> That may be easier to configure than IPSec in some environments.

take a look at sfs: http://www.fs.net/


-- 
Aaron Denney
-><-
