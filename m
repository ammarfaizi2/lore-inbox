Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbRERUq7>; Fri, 18 May 2001 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbRERUqt>; Fri, 18 May 2001 16:46:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63247 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261550AbRERUqk>; Fri, 18 May 2001 16:46:40 -0400
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
To: Wayne.Brown@altec.com
Date: Fri, 18 May 2001 21:43:03 +0100 (BST)
Cc: esr@thyrsus.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <86256A50.006E3D90.00@smtpnotes.altec.com> from "Wayne.Brown@altec.com" at May 18, 2001 03:04:43 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150r5T-0007gK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 05/18/2001 at 02:44:07 PM esr@thyrsus.com wrote:
> >But the real question is whether the old tools have enough value to be
> >worth the effort.  What problem are you trying to solve here?
> 
> How about:
> 1.  Some of us are perfectly satisfied with the existing tools and don't want
>       them to be yanked out from under us.

> 2.  Some of us have no interest in Python and don't like being forced to deal
>       with installing/upgrading it just for CML2.

Since someone is rewriting CML2 in C that #2 is a non issue. #1 may be a case
of bolting alternative ui's onto the parser 

