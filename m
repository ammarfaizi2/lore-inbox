Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWFQK6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWFQK6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWFQK6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:58:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:20104 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751336AbWFQK6F (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:58:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SOEEL6axQhdfbmibq2yRsCEKONCV5pMbudphfY9rSu1QcPeMH1FMRRJtE7GdaE6MBKYCijKYNETnvOT0bh245Zz5PsDKmh3wM2PR15DZxpSg79D3/KuPqwFeF10BFB28oMA/ye6rrTIAVH8eyuYJ5xdXgEIoKtcI7V2uVz4C6eA=
Message-ID: <9a8748490606170358p4cf1068bh1ab6ba510c98f2d@mail.gmail.com>
Date: Sat, 17 Jun 2006 12:58:04 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Subject: Re: a newbie with the kernel--a few questions
Cc: "sena seneviratne" <auntvini@cel.usyd.edu.au>,
       "Tyler Littlefield" <compgeek13@gmail.com>,
       linux-Kernel@vger.kernel.org
In-Reply-To: <200606161541.39498.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5.1.1.5.2.20060616111106.04488d40@brain.sedal.usyd.edu.au>
	 <5.1.1.5.2.20060616132151.04502988@brain.sedal.usyd.edu.au>
	 <200606161541.39498.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > At 09:12 PM 6/15/2006 -0600, you wrote:
> > >OK, I am pretty good with c. My goal here is... Well, when a user types
> > > who, I don't want it to work, unless its root. (easy to change) but I
> > > want some security like that in the kernel. Also, I want to limit it to
> > > when the user types ps, they can't get everyone's processes, but jsut
> > > there own, unless of course, they are root.
> > >Thanks,
>
> Might also be worth looking at patches like GrSecurity which make general
> policy changes (such as these) and are well tested and robust.
>

Isn't this already doable with SELinux ?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
