Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTJaMup (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTJaMuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:50:44 -0500
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:17544 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S263271AbTJaMuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:50:44 -0500
To: bd <bdonlan@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
X-URL: <http://www.linux-mandrake.com/
References: <20031030141519.GA10700@redhat.com>
	<u6f871-68s.ln1@bd-home-comp.no-ip.org>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Fri, 31 Oct 2003 12:50:42 +0000
In-Reply-To: <u6f871-68s.ln1@bd-home-comp.no-ip.org> (bdonlan@users.sourceforge.net's
 message of "Thu, 30 Oct 2003 17:16:30 -0500")
Message-ID: <m2r80t1sgt.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bd <bdonlan@users.sourceforge.net> writes:

> > - The format of /proc/stat changed, which could break some
> >   applications that still depend on the old layout.
> >   Currently the only known application to break is the java
> >   'DOTS' app. (http://bugme.osdl.org/show_bug.cgi?id=277)
> 
> 'xosview' is also broken by this change.

there's a patch around the net that fix it (alternatively, you got it
from the xosview source rpm from mandrake contribs)

