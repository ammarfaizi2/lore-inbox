Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWD0NHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWD0NHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 09:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWD0NHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 09:07:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:62797 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965032AbWD0NHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 09:07:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LaymILMV01voWsQKxAKeFYoY0j19RSxYDy3YNFBv+kU7ujfipchspqL6sd5iiiYL+LQ4p48MVy/7O/8/4G2sdbqDl5+3PYKmJP3gYmFk/c8T3o5UI6hiwAxO1omDt7nypYTAOClDOAVxdr40O70fSsCfWb+qzB3r0gunmY/Xo/o=
Message-ID: <6bffcb0e0604270607r1b902c67pb20691a5b6c1ac63@mail.gmail.com>
Date: Thu, 27 Apr 2006 15:07:54 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc2-mm1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <6bffcb0e0604270327n76e24687s1a36d8985f8c2d27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060427014141.06b88072.akpm@osdl.org>
	 <6bffcb0e0604270327n76e24687s1a36d8985f8c2d27@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi Andrew,
>
> On 27/04/06, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc2/2.6.17-rc2-mm1/
> >
> [snip]
> > +gregkh-devfs-ndevfs.patch
>
> "You don't really want to run this.  But if you did, here's a simple hack
> showing how easy it is to do it.
>
> Note, this patch will NOT be merged into mainline, so don't get your
> panties into a bind..."
> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/ndevfs.patch
>
> Please drop this patch.

Here is oops:
http://www.stardust.webpages.pl/files/mm/2.6.17-rc2-mm1/oops1.jpg

Here is config:
http://www.stardust.webpages.pl/files/mm/2.6.17-rc2-mm1/mm-config

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
