Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVGZKgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVGZKgx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGZKgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:36:52 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:19656 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261662AbVGZKgw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:36:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B6rkngrmMegPVNqLvpOIi6Mns3f0gWyRrB6gVAcdIDzLNUhRima1MjNocM//SfbnQRo81A0WY2JyJq4a8QZ19k7i8M41jTRhhFnKlT6giZk2BoGke/qYhVdO+ZqI1f4DV/yS6sdScLL3cgGdJ6WMLB1G5/tozGJHG8FEtEwwLAI=
Message-ID: <105c793f050726033672560fd4@mail.gmail.com>
Date: Tue, 26 Jul 2005 06:36:51 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Jaroslav Kysela <perex@suse.cz>
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507260828030.8190@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f05072507315cfd1878@mail.gmail.com>
	 <Pine.LNX.4.61.0507260828030.8190@tm8103-a.perex-int.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/05, Jaroslav Kysela <perex@suse.cz> wrote:
> We have already two similar reports #440 and #879. Please, provide us
> all info (working manual conf etc.)..
Yes. #879 is the one that mentions that this might be a kernel bug (so
I reported it here):

"I suspect this is kernel bug and it conserns ISA support.
I would be happy if you kick some kernel developers buts because they
have ignored my bugreport for quite long time now."

I don't know how correct/incorrect the above may be, but I figured it
was possible.

I'll report what I know in bug #879.

Thanks.

-Andy
