Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWJQPet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWJQPet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWJQPet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:34:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:18697 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWJQPes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GFaRleBLDyi7JvK+XiNHtVP4eWXeIHLnU5PEkSbq4BFFAvdXI7KCtrVeW+JM8O/xjbrlnMT2aNxYcmwMzX4ln6M/6/FHWXmvbJNI9njuiqBknlJraE4E17Axt7v2VkxY7nun1bvVTUvpzvXvb0GuoqfWRyxdjvPNjIHWxoTcHyw=
Message-ID: <d120d5000610170834i6b3c47a0t2b666a603a0553d0@mail.gmail.com>
Date: Tue, 17 Oct 2006 11:34:46 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [git pull] Input patches for 2.6.19-rc2
Cc: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610170820220.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610162356.52100.dtor@insightbb.com>
	 <Pine.LNX.4.64.0610170820220.3962@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 16 Oct 2006, Dmitry Torokhov wrote:
> >
> > Please pull from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
>
> "error: no such remote ref refs/heads/for-linus"
>
> Forgot to push?
>
>                Linus
>

Oops, sorry, it was a cut-and-paste error from my previous pull
request. There is no "for-linus" branch at the moment, I would like
you to just pull from my tree.

-- 
Dmitry
