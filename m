Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280727AbRKOQZS>; Thu, 15 Nov 2001 11:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280934AbRKOQY7>; Thu, 15 Nov 2001 11:24:59 -0500
Received: from mx6.port.ru ([194.67.57.16]:11535 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S280727AbRKOQYt>;
	Thu, 15 Nov 2001 11:24:49 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111151330.fAFDU1x01012@vegae.deep.net>
Subject: Re: 3.0.2 breaks linux-2.4.13-ac8 in tcp.c
To: rml@tech9.net (Robert Love)
Date: Thu, 15 Nov 2001 16:30:01 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005024259.1376.4.camel@phantasy> from "Robert Love" at Nov 06, 2001 12:24:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Robert Love wrote:"
> 
> On Tue, 2001-11-06 at 00:13, Samium Gromoff wrote:
> >      well, not too much to add, maybe except that the RAM is ok and CPU is not
> >    OC`ed...
> > [...]
> > tcp.c: In function `tcp_close':
> > tcp.c:1978: Internal compiler error in rtx_equal_for_memref_p, at alias.c:1121
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
> 
> This is the GCC team's worry -- it is an internal GCC bug.  Send them
> the compile log and the source file in question.
   Well, i understand this, its just that i liked to ensure that the community
 is aware of this problem... :)
> 
> See http://www.gnu.org/software/gcc/bugs.html
> 
> 	Robert Love
> 
> 

cheers, Samium Gromoff
