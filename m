Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269777AbUJGKQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269777AbUJGKQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbUJGKQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:16:22 -0400
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:22865 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S269777AbUJGKPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:15:55 -0400
From: Nick Sanders <sandersn@btinternet.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm3
Date: Thu, 7 Oct 2004 11:16:06 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041007015139.6f5b833b.akpm@osdl.org> <200410071041.20723.sandersn@btinternet.com> <20041007025007.77ec1a44.akpm@osdl.org>
In-Reply-To: <20041007025007.77ec1a44.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410071116.06967.sandersn@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 October 2004 10:50, Andrew Morton wrote:
> Nick Sanders <sandersn@btinternet.com> wrote:
> > On Thursday 07 October 2004 09:51, Andrew Morton wrote:
> >  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc
> >  >3/2.6 .9-rc3-mm3/
> >
> >  I get the following oops when booting and it also stops kde
> > (artswrapper) from starting with the same call trace. USB seems to be
> > working which is good.
>
> Could you please do
>
>
> cd /usr/src/linux
> wget
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6
>.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch patch -R -p1 <
> optimize-profile-path-slightly.patch
>
> and retest?
> -

Patch fixes problem. Thank you !

Regards

Nick
