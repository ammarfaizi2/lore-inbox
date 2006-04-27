Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751814AbWD0WJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbWD0WJT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 18:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWD0WJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 18:09:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:21743 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751814AbWD0WJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 18:09:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W5b/rEbFh8tlwCqhvuSNilhc5eW68RH4e7gg+A5bXYQHaMIM8SMXU/ktI/E1ZaI1O52KJITsrzqJwttA79ktPCcHdI3G/0FdRxBR4arig+qKe516lpLMQzttMaFKdYGQMQRWUiLSSepoc9PC/K+52NRDk0ZPJ30oH3jLecEco1Q=
Message-ID: <6bffcb0e0604271509t1be7bbfar25d1f0065d6929ea@mail.gmail.com>
Date: Fri, 28 Apr 2006 00:09:18 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: 2.6.17-rc2-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060427205319.GA30610@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060427014141.06b88072.akpm@osdl.org>
	 <6bffcb0e0604270327n76e24687s1a36d8985f8c2d27@mail.gmail.com>
	 <6bffcb0e0604270607r1b902c67pb20691a5b6c1ac63@mail.gmail.com>
	 <20060427152802.GC15806@suse.de>
	 <6bffcb0e0604270832o514f97bi45f871e2cfc832c6@mail.gmail.com>
	 <20060427205319.GA30610@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/06, Greg KH <gregkh@suse.de> wrote:
[snip]
> Ok, I've spent a bit of time trying to reproduce this and I can't.  So
> I'm just going to drop it from the patch set, because as you point out,
> it's never going to go to mainline anyway, it was just a fun hack.
>
> Sorry for the noise,
>
> greg k-h
>

Thanks.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
