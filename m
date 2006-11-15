Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966711AbWKOJAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966711AbWKOJAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 04:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966712AbWKOJAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 04:00:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:17930 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966711AbWKOJAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 04:00:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RorJCqMA0aiNykq6sAyuO14CRZ4X3L7zy4ltVlJ1NSyZUcT3lUE1v7VpjWTXojCsGz2RaQ0LmHSS8+JdwA/6sRqVHvsUsSiMCnOgg0WPc0cLOA6TQrDwT9scIF53ZIRB4T3WMiyP28l6gnGh8HN4sjQWesA8McvMPLJA29L7Y7Q=
Message-ID: <40f323d00611150100p45ab1a78w4fa94be8ab6b5726@mail.gmail.com>
Date: Wed, 15 Nov 2006 10:00:18 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: 2.6.19-rc5-mm2 -- 3d slow with dynticks
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <1163577265.31358.83.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
	 <1163577265.31358.83.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-11-14 at 23:56 +0100, Benoit Boissinot wrote:
> > On 11/14/06, Andrew Morton <akpm@osdl.org> wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/
> > >
> >
> > CONFIG_NO_HZ=y still gives me slow 3d games on this one whereas
> > 2.6.19-rc5-mm1 +
> > http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff was fine.
> >
> > Maybe some patches where not merged ?
>
>
> what video is this?
>
i915, do you need .config, dmesg or lspci ?

regards,

Benoit
