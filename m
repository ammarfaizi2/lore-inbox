Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWERSwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWERSwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWERSwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:52:35 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:46354 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751381AbWERSwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:52:34 -0400
To: linux cbon <linuxcbon@yahoo.fr>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
X-URL: <http://www.mandrivalinux.com/
References: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com>
From: Thierry Vignaud <tvignaud@mandriva.com>
Organization: Mandriva
Date: Thu, 18 May 2006 20:52:31 +0200
In-Reply-To: <20060518172827.73908.qmail@web26601.mail.ukl.yahoo.com> (linux cbon's message of "Thu, 18 May 2006 19:28:27 +0200 (CEST)")
Message-ID: <m2odxvdv2o.fsf@vador2.mandriva.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux cbon <linuxcbon@yahoo.fr> writes:

> Why dont we have "good" 3D support in X ?

no documentation how to program nvidia 3d chips?
or for the very latest ati chips?
or from the XYZ vendor?
....

> > Also, please tell why this would be faster, simpler, or easier to
> > manage.  Stuff in the kernel is generally harder to manage than
> > userspace stuff, and definitely not simpler.  Kernel code lives
> > with all sorts of requirements and limitations that an application
> > programmer would hate to have to worry about.
> 
> Put X in the kernel, so we dont have 7924 bad written
> incompatible implementations of it.

no, we now have 7924 kernels that have to implement each of these
drivers (linux, *bsd, other unices, macos x, ...)
ow! how do we do with macos x? or on windows?
no more X? (though i don't really care but...)

> In my opinion, graphics do belong to the OS, like
> sound, network and file system.

"belong to the OS" != "belong in the kernel"
and where do you put the boundary of the OS? most people don't say
that the OS is only the kernel...

> 
> How to improve/replace X :
> http://keithp.com/~keithp/talks/xarch_ols2004/xarch-ols2004-html/
> http://www.doc.ic.ac.uk/teaching/projects/Distinguished03/MarkThomas.pdf

like if xorg wasn't trying to improve x11 status (slowly trying to
isolate priviliged stuff, introducing xcb, ...)

> What is your opinion ? 

stop troll^h^h^h^h^h thread?
