Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbRECWej>; Thu, 3 May 2001 18:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135284AbRECWea>; Thu, 3 May 2001 18:34:30 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:15066 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135283AbRECWeU> convert rfc822-to-8bit; Thu, 3 May 2001 18:34:20 -0400
Date: Fri, 4 May 2001 00:34:18 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
cc: liste noyau linux <linux-kernel@vger.kernel.org>,
        liste dev network device <netdev@oss.sgi.com>
Subject: Re: NEWBEE "reverse ioctl" or someting like
In-Reply-To: <20010503142929.773147bf.sebastien.person@sycomore.fr>
Message-ID: <Pine.SOL.4.33.0105040033430.27646-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 3 May 2001, sébastien person wrote:

> I think that use of pipe isn't preconised because I must fork process
> to use pipe, I search something like ioctl but in the other way :
>
>  kernel process ---> user process

What about using /proc/ ?

Gruß,
Markus
-- 
| Gluecklich ist, wer vergisst, was nicht aus ihm geworden ist.
+---------------------------------------.     ,---------------->
http://www.uni-ulm.de/~s_mschab/         \   /
mailto:markus.schaber@student.uni-ulm.de  \_/


