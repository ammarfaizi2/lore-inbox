Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285655AbRLTAGH>; Wed, 19 Dec 2001 19:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285656AbRLTAF5>; Wed, 19 Dec 2001 19:05:57 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:37573 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S285655AbRLTAFk> convert rfc822-to-8bit; Wed, 19 Dec 2001 19:05:40 -0500
Message-ID: <3C212B8A.C22F31E8@oracle.com>
Date: Thu, 20 Dec 2001 01:06:34 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?iso-8859-1?Q?Ra=FAl=20N=FA=F1ez?= de ArenasCoronado 
	<raul@viadomus.com>,
        linux@sneulv.dk
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
In-Reply-To: <E16GnOs-0000JT-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raúl Núñez de Arenas Coronado wrote:
> 
>     Hello all :))
> 
> >> Is it safe to use gcc-3.0.2 to compile the kernel?
> >If it compiles.. Otherwise use gcc-3.0.3(prerelease), it has fixes that makes
> >the _current_ kernel compile.
> 
>     I've using gcc-3.0.1 to compile the kernel since it was released
> and my linux 2.4.16 runs without problems. In my experience, the only
> problem is the ICE raised by the 8139too driver, although this seems
> to have been corrected on gcc-3.0.2 (I haven't updated my compiler
> yet). I haven't found any bug yet running my linux box, but this
> doesn't mean that gcc-3.0 is safe for the kernel. It's safe for my
> configuration of the kernel, at least.

Been compiling my kernel with 3.0.2 since the day it was out and have
 found no bugs so far. Raul's disclaimer applies in my case too - of
 course.

--alessandro

 "we live as we dream alone / to break the spell we mix with the others
  we were not born in isolation / but sometimes it seems that way"
     (R.E.M., live intro to 'World Leader Pretend')
