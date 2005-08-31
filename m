Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVHaUJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVHaUJb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVHaUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:09:31 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:2082 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964930AbVHaUJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:09:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MPWAHWy/mpWOYnaCC8ehdB41lNeoxfXOx4jfqzBS95l3nyNEdNbHSIRpjeAMVVLawtc63fZiq2RO23UGHl8lMd0VE0T+p+KO1MX5Mkg09vZapqS/uzSDGEgQApw5/sDIxaTSbURcdIV5nRglbQ+X3hbRwby3zujDnlCTpTNID5c=
From: daniel mclellan <daniel.mclellan@gmail.com>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [ck] 2.6.13-ck1
Date: Wed, 31 Aug 2005 15:07:10 -0500
User-Agent: KMail/1.8.2
References: <200508291703.26529.kernel@kolivas.org> <20050831194958.GA7021@spherenet.spherevision.org>
In-Reply-To: <20050831194958.GA7021@spherenet.spherevision.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508311507.10801.daniel.mclellan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.


Linux yavanna 2.6.13-ckx1 #1 Tue Aug 30 04:03:25 EST 2005 x86_64 AMD 
Athlon(tm) 64 FX-53 Processor AuthenticAMD GNU/Linux



On Wednesday 31 August 2005 14:49, Rodney Gordon II wrote:
> On Mon, Aug 29, 2005 at 05:03:24PM +1000, Con Kolivas wrote:
> > These are patches designed to improve system responsiveness and
> > interactivity. It is configurable to any workload but the default ck*
> > patch is aimed at the desktop and ck*-server is available with more
> > emphasis on serverspace.
> >
> >
> > Apply to 2.6.13
> > http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1.bz2
> > or development version:
> > http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1+.bz2
> >
> > or server version:
> > http://ck.kolivas.org/patches/2.6/2.6.13/2.6.13-ck1/patch-2.6.13-ck1-serv
> >er.bz2
>
> I am having odd lockup problems with just the non-+ 'stable' ck lately..
> Trying a large copy will often lock my disk I/O up and I have to do a hard
> reboot. Nothing shows in logs..
>
> Is anyone having similar problems?
>
> -r
