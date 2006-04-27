Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWD0PdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWD0PdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWD0PdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:33:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:65528 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030189AbWD0PdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:33:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jZRuMusUe+G62rLcfLQ5u+1K1FOb1LZmD/gUG8Njd38aEMjR0IweqQdzp4i5gmPr5qJu4NwGfWLMQzP1AvD0CvjX+p2QJx9y1UsP7etoQslH8IT6quPKcZMAZsYjjduphQEG4SWUTenVOGHn9Qy1K1omQDJmuIzin01Vx++AFYM=
Message-ID: <6bffcb0e0604270832o514f97bi45f871e2cfc832c6@mail.gmail.com>
Date: Thu, 27 Apr 2006 17:32:43 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: 2.6.17-rc2-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060427152802.GC15806@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060427014141.06b88072.akpm@osdl.org>
	 <6bffcb0e0604270327n76e24687s1a36d8985f8c2d27@mail.gmail.com>
	 <6bffcb0e0604270607r1b902c67pb20691a5b6c1ac63@mail.gmail.com>
	 <20060427152802.GC15806@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 27/04/06, Greg KH <gregkh@suse.de> wrote:
[snip]
>
> Ah, I guess it is causing you problems :)
>
> > Here is config:
> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc2-mm1/mm-config
>
> If you set CONFIG_NDEV_FS=n does the oops go away?

Yes.

>
> thanks,
>
> greg k-h
>

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
