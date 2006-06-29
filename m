Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWF2CQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWF2CQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 22:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWF2CQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 22:16:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:45528 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750831AbWF2CQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 22:16:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RtAK/9QhLlJ82RgW3vkOeLqVm7Gjt4P5qdEKRMT5xux/Xquzi7RNd102fJ3lNmgfoOKuv25zj9gVzpZ3xpUtLWpadXPO1n20fG+4aIHDbjZ1LHO7Yp/7a73EBodcuqDRGJTcOX9HkDNOvMndECExbKIec0KZ/pqizktn3w9dS9g=
Message-ID: <b6a2187b0606281916y5d19485ave073bf924c9d3552@mail.gmail.com>
Date: Thu, 29 Jun 2006 10:16:47 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
Subject: Re: 2GB or 4GB SD support for Linux 2.6.17?
Cc: lkml <linux-kernel@vger.kernel.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <44A181EC.2010601@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0606252154i42b031c7tbc72235e5ad4313c@mail.gmail.com>
	 <44A181EC.2010601@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre,

Please repost the patch or send it to me. I'm very keen to test it. I
know the SDs are working as I can read from using an USB card reader.

Thanks, Jeff.


On 6/28/06, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Jeff Chua wrote:
> > I tried both 2GB and 4GB SD card on 2.6.17 and both failed. But 1GB
> > works fine.
> >
>
> Known issue and I have a patch sent for review with Russell.
> Unfortunately, he has commitments elsewhere. So we have to be patient a
> bit longer.
>
> Rgds
> Pierre
>
