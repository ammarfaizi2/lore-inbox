Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264151AbUD0OMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbUD0OMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUD0OMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 10:12:45 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:63492 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264160AbUD0OLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 10:11:02 -0400
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1083074728@astro.swin.edu.au>
Subject: Re:  [PATCH] Blacklist binary-only modules lying about their license (-> possible GPL violation :)
In-reply-to: <20040427131257.GG29503@lug-owl.de>
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach> <20040427092159.GC29503@lug-owl.de> <408E37D9.7030804@gmx.net> <408E5944.8090807@grupopie.com> <20040427131257.GG29503@lug-owl.de>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-10615-8854-200404280005-tc@hexane.ssi.swin.edu.au>
Date: Wed, 28 Apr 2004 00:10:55 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> said on Tue, 27 Apr 2004 15:12:57 +0200:
> 
> --+sHJum3is6Tsg7/J
> Content-Type: text/plain; charset=iso-8859-1
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, 2004-04-27 13:59:48 +0100, Paulo Marques <pmarques@grupopie.com>
> wrote in message <408E5944.8090807@grupopie.com>:
> > Carl-Daniel Hailfinger wrote:
> > >This way, the module format doesn't change, but we can do additional
> > >verification in the loader.
> >=20
> > The way I see it, they know a C string ends with a '\0'. This is like=20
> > saying that a English sentence ends with a dot. If they wrote "GPL\0" the=
> y=20
> > are effectively saying that the license *is* GPL period.
> >=20
> > So, where the source code? :)
> 
> That's another (quite amusing:) point of view. Anybody willing to ask a
> lawyer?

In the wonderful Good Ol USofA, I think it would be trivial to apply
the DMCA: A character string following the appropriate convention
(null termination) is a protection mechanism.

Breaking that convention is a cicumvention device.

If it can work for XOR, and gets someone thrown in prison for 12
months, surely it will work for null termination?

Pretty clear cut, so, who's going to write this lovely company a
letter/send in the land-sharks (someone better, otherwise companies
will realise very quickly that they can stamp all over us with no
retribution[1])? I don't own any relevant copyright, unfortunately.

[1] Has anything been done about the other members on the hall or
shame?

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
HANDLE WITH EXTREME CARE: This Product Contains Minute Electrically
Charged Particles Moving at Velocities in Excess of Five Hundred
Million Miles Per Hour.
