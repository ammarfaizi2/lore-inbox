Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262453AbTCRO5S>; Tue, 18 Mar 2003 09:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbTCRO5R>; Tue, 18 Mar 2003 09:57:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60420 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S262453AbTCRO5J>;
	Tue, 18 Mar 2003 09:57:09 -0500
Date: Tue, 18 Mar 2003 09:08:00 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Demand paging - Kernel
Message-Id: <20030318090800.57118796.reynolds@redhat.com>
In-Reply-To: <200303172159.h2HLxsQY025585@pincoya.inf.utfsm.cl>
References: <20030317083547.51a4004f.reynolds@redhat.com>
	<200303172159.h2HLxsQY025585@pincoya.inf.utfsm.cl>
Organization: Red Hat GLS
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss
 of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Horst von Brand <vonbrand@inf.utfsm.cl>, spoke thus:

> Tommy Reynolds <reynolds@redhat.com> said:
> > Uttered "Breno" <brenosp@brasilsec.com.br>, spoke thus:
> > > There is a possibility  to do demand paging in kernel space address ?
> > No.  The entire kernel, and all  of its data structures, are resident in
> > memory  all of  the time.
> The cost of doing it right in a monolitic kernel would probably outweigh
> the gains manyfold, and require massive redesign for Linux. In microkernels
> it is a lot easier to do (but their performance sucks baby elephants
> through straws, so they are moot :-)

Dr. von Brand,

Thanks for  following up on  this.  You are  right, of course:  with the
source code and  enough patience anything could be  crafted.  I answered
in the sense of "is this currently implemented", and it's not ;-)

