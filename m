Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWBKUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWBKUJk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 15:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWBKUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 15:09:40 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:64706 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964781AbWBKUJj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 15:09:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QOFVgOHGlWrM6CJRG1dlVyryn6iCIvhwJVe8yYcVSam/E7prXpc6flUeX2Y5i1QARE8xMsU0NbK8mZf6PjHyAeP5MUkMGzxNYLFceAOZR807FqKWFvAkBxavoiTHe4IycuCAKInaz5YPAnNSbsCBS/e2xQWDC0y2a4sO+lXsoyA=
Message-ID: <6bffcb0e0602111209x568e38f7j@mail.gmail.com>
Date: Sat, 11 Feb 2006 21:09:38 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: Re: old patches in -mm
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <43EE415F.2000805@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43EE415F.2000805@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/02/06, Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:
> hi,
>
> There are 35 patches(not included reiser4 and post-halloween-doc) older
> than 2 months that still are not in mainline. Forgotten or experimental ?
[snip]
> oops-reporting-tool.patch

It is useful only for kernel testers.

BTW here is new version:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/ltg/

Regards,
Michal Piotrowski
