Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290693AbSAYPbB>; Fri, 25 Jan 2002 10:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290697AbSAYPas>; Fri, 25 Jan 2002 10:30:48 -0500
Received: from cpe.atm2-0-105125.0x3ef2066b.hrnxx2.customer.tele.dk ([62.242.6.107]:6483
	"HELO mars.ravnborg.org") by vger.kernel.org with SMTP
	id <S290693AbSAYPae>; Fri, 25 Jan 2002 10:30:34 -0500
Date: Fri, 25 Jan 2002 16:32:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] kernelconf-0.1.2
Message-ID: <20020125163213.A1635@mars.ravnborg.org>
Mail-Followup-To: Anuradha Ratnaweera <anuradha@gnu.org>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020124124548.A2435@lklug.pdn.ac.lk> <20020124234704.A968@mars.ravnborg.org> <20020125160734.A3372@lklug.pdn.ac.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020125160734.A3372@lklug.pdn.ac.lk>; from anuradha@gnu.org on Fri, Jan 25, 2002 at 04:07:34PM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 04:07:34PM +0600, Anuradha Ratnaweera wrote:
> > 
> > This is an incomplete implementation of a CML2 parser + semantic analysis in
> > C utilising a bison parser.
> 
> My program is not related to neither CML2 nor yacc nor bison.

It was not obvious from the context but I was referring to a mail you
sent some time ago when you announced this project:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101168996304715&w=2

"I'd love to write a CML2 compiler in
C, but it doesn't look like a viable alternative."

Following the discussion on LKML and the KBUILD list people
dislike the choice of Phython version 2.x for the actual
implementation of the CML2 "compiler" and frontends.
In general few people has argued against the language itself.

Therefore my intention was to point you in the direction of
an although incomplete implementation of a CML2 compiler
written in C.
This could give you the possibility to use the well documented
and by several people already accepted CML2 language, but at the
same time you had the flexibility to create your own front-end.

	Sam
