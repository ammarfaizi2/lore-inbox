Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVK3OCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVK3OCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 09:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVK3OCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 09:02:04 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:33666 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751238AbVK3OCD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 09:02:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=taR70R0jp+biOjq4UKfx7218FP+257yBegBHX7wgCt1E0xGd3vzxQTHT30t0CHLV0q/N74PLF/u9tReaAeA1HIueKiZGWTLJ2nE4wnuY5t/oVuO650lw2g5KCAlTjuBmHG6H3cvdLikLPLXexoBmSaQ+EGyEK+k+o1rCj9S+BcU=
Message-ID: <9a8748490511300602u2cf9f972od6617b8fe777bd9a@mail.gmail.com>
Date: Wed, 30 Nov 2005 15:02:01 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: 3C905C-TX
Cc: =?ISO-8859-1?Q?Daniel_H=F6hnle?= <hoehnle.dan@googlemail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, andrewm@uow.edu.au,
       netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.61.0511300813190.18193@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <eab8d9e30511300459j695ed942n@mail.gmail.com>
	 <Pine.LNX.4.61.0511300813190.18193@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Wed, 30 Nov 2005, [iso-8859-1] Daniel Höhnle wrote:
>
> > Hello i have Suse Linux 9.3 and a 3Com 3C905C-TX Networkcard. But she
> > don't works. Where can I get a Driver??? Or give it a Dokumentation
> > how I can make the Driver??
> >
> > Thanks
> > Daniel Höhnle
>
> The 3c59x driver should work for this device. If it's real
> new, you may have to add its ID to the structure at line
> 3365 in 3x59x.c or contact the maintainer.
>
The 3c90x driver available from 3COM themselves is another alternative
: http://support.3com.com/infodeli/tools/nic/linuxdownload.htm

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
