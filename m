Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWFATER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWFATER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbWFATER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:04:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:21176 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965278AbWFATEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:04:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pIRaFdjnK6COGCEyLMOzcKN7KEfbvQgVrBJtI7kEyj29InSExyFCRBqKyuJifjYsjS1lQaJ9oC4zbReL3zdNJAVc7O+8d4lTRCQ/PMzK/hvX2QmoNxajbvuau4v8VHCRYkKXrGbYq1uQOeDTZ+3ybZUaAwNJvRft7lTmm1dQuek=
Message-ID: <6bffcb0e0606011204t2ff23462o2a6d414c40b01bbc@mail.gmail.com>
Date: Thu, 1 Jun 2006 21:04:16 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, "Greg KH" <gregkh@suse.de>,
       "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1149182408.3115.75.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <6bffcb0e0606010851n75b49d83u9f43136b3108886c@mail.gmail.com>
	 <1149182408.3115.75.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On 01/06/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> On Thu, 2006-06-01 at 17:51 +0200, Michal Piotrowski wrote:
> > Hi,
> >
> > On 01/06/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > >
> >
> > I don't know why, but first bug appears only when avahi-daemon is
> > started. Second look like a problem with my camera.
> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
> > http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_2.jpg
> >
> > Here is config http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config
>
>
> can you confirm this fixes it ?
>

Probably yes, I'm not 100% sure. I'll do some tests (do stupid things
with camera while reboot).

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
