Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265248AbSJWWIP>; Wed, 23 Oct 2002 18:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265251AbSJWWIO>; Wed, 23 Oct 2002 18:08:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22452 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265248AbSJWWIM> convert rfc822-to-8bit; Wed, 23 Oct 2002 18:08:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Gilad Ben-ossef <gilad@benyossef.com>
Subject: Re: One for the Security Guru's
Date: Wed, 23 Oct 2002 15:14:07 -0700
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021023130251.GF25422@rdlg.net> <1035380716.4323.50.camel@irongate.swansea.linux.org.uk> <1035381547.4182.65.camel@klendathu.telaviv.sgi.com>
In-Reply-To: <1035381547.4182.65.camel@klendathu.telaviv.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231514.07192.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 06:59 am, Gilad Ben-ossef wrote:
> On Wed, 2002-10-23 at 15:45, Alan Cox wrote:
> > On Wed, 2002-10-23 at 14:02, Robert L. Harris wrote:
[ Snip! ]
>
> .... For example - when you
> download a new update of a kernel (or any program for that matter)
> source/patch (or binary package) from the net do you check the GPG
> signature validity? I would be VERY surprised if you answer 'yes'...
>
> :-))
>
> Gilad.

Be surprised:  I run "gpg --verify foo.tgz.sign foo.tgz" every time I download 
from kernel.org.  And, "rpm --checksig *.rpm" on stuff from redhat.com too.

Given the recent trojaned source packages, I recommend that everyone do the 
same.

	=	=	=	=

The preceding public service message has been sponsored by Anal Retentive 
Sysadmins .Org  (Motto:  Constipation:  It's not just a gob, it's a career!)

> > Alan


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

