Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947257AbWKKQbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947257AbWKKQbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947258AbWKKQbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:31:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26631 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1947257AbWKKQbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:31:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HQinjOR+4rPNgGDFw3xOE4Vvw/d59uxm33ajIEWOilELwnBerfVMiMsmIBT7OUHvZY/+SYCsrFsPrODg9dHQeUjOJF0v4eLCM6Mw7z14pTMLUTXiKLTcfuReqFnlBGhVl5KylBS7+HzP+w03lp3PgiIdz/A2S8QmcK/dbu0QQ7c=
Message-ID: <4d8e3fd30611110831q6b597ec4gd505b33abd1c3244@mail.gmail.com>
Date: Sat, 11 Nov 2006 17:31:03 +0100
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [TRIVIAL PATCH] Added information about Technisat Sky2Pc cards - take 3
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <1163262465.3293.40.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4d8e3fd30611110819r7e4dc941od93b9eb1220f2992@mail.gmail.com>
	 <1163262465.3293.40.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-11-11 at 17:19 +0100, Paolo Ciarrocchi wrote:
> > Hi all,
> > This is the third time I submit the below patch (first sent on the
> > 29th of October), I'm adding lkml and Adrian since this is really
> > trivial.
>
> hi

Hi Arjan,

> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/dvb/cards.txt b/Documentation/dvb/cards.txt
> > index ca58e33..cc09187 100644
> > --- a/Documentation/dvb/cards.txt
> > +++ b/Documentation/dvb/cards.txt
> > @@ -22,10 +22,10 @@ o Frontends drivers:
> >    - ves1x93           : Alps BSRV2 (ves1893 demodulator) and dbox2 (ves1993)
> >    - cx24110           : Conexant HM1221/HM1811 (cx24110 or cx24106
> > demod, cx24108 PLL)
> >    - grundig_29504-491 : Grundig 29504-491 (Philips TDA8083
> > demodulator), tsa5522 PLL
> > -   - mt312             : Zarlink mt312 or Mitel vp310 demodulator,
>
> Hi,
>
>
> your patch has gotten line-wrapped, so it's not possible to apply it
> using the patch command ;(
>
> you may need to resend it as an attachment to get it not damaged ;(
>

Sure, will do that as soon as I can access to the box running linux and git.

Thanks!

Regards,
-- 
Paolo
http://docs.google.com/View?docid=dhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
