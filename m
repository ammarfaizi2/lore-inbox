Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbREUMIo>; Mon, 21 May 2001 08:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261176AbREUMIY>; Mon, 21 May 2001 08:08:24 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:60209 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S261173AbREUMIQ>; Mon, 21 May 2001 08:08:16 -0400
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
From: Robert "M." Love <rml@tech9.net>
To: Mike "A." Harris <mharris@opensourceadvocate.org>
Cc: Jes Sorensen <jes@sunsite.dk>, John Cowan <jcowan@reutershealth.com>,
        esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0105210205520.1590-100000@asdf.capslock.lan>
In-Reply-To: <Pine.LNX.4.33.0105210205520.1590-100000@asdf.capslock.lan>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 21 May 2001 08:08:03 -0400
Message-Id: <990446886.1097.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2001 02:11:39 -0400, Mike A. Harris wrote:
> On 20 May 2001, Robert M. Love wrote:
>>(on another note, about the coexist issue: am i going to have a python
>>and python2 binary? so now the config tool will find which to use, ala
>>the kgcc mess? great)
>
> For the record, the kgcc "mess" you speak of was used by
> Conectiva, and I believe also by debian before adoption in Red
> Hat Linux.  It was about as good a solution as one could get for
> the problem that it solved - the kernel being broken and unable
> to build with our gcc-2.96.  Just to head anyone off at the
> pass... the kernel is fixed and now builds properly with
> gcc-2.96.

my view of the mess wasn't the fact RedHat used kgcc. i think that was a
good move.

i mean how in 2.2 the Makefile must search out for gcc, kgcc, gcc-2.95,
gcc-2.91 etc. what is the cml2 parser going to do? search for my python2
binary because my python1 binary is my "standard" python?

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

