Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751504AbWFDPJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWFDPJb (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWFDPJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 11:09:31 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:35317 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751504AbWFDPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 11:09:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ri8OkEjjc/MzZmbfLXFHyoko8TCgVEnVf+LInjFjsUTeWR3gGbey/DoeScLJ/981TReXnRejfJHpEZ1ztTNmAO7ioqyNK+UP07nVGroYztFlrtC4g62rF/ycVjZMD0S8g6xZb/QSMVDhONcIbd6+KyJfx9UWk9Ya0q9z76A3bvQ=
Message-ID: <beee72200606040809m601de430jefb1a8760619353d@mail.gmail.com>
Date: Sun, 4 Jun 2006 17:09:29 +0200
From: "davor emard" <davoremard@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: SMP HT + USB2.0 crash
In-Reply-To: <20060604145420.GA26218@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606042142.01879.kernel@kolivas.org>
	 <beee72200606040729u4c660583g1b7e669b85db5bca@mail.gmail.com>
	 <20060604145420.GA26218@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Either hire a professional sysadmin, or disable CONFIG_PREEMPT
>

I tried it also with SMP enabled and disabled PREEMPT and
big kernel lock preempt - it also crashes.

So there's no need for a yet more professional sysadmin I guess.

Try it yourself on your machine if you have handy some intel 925X series
to crash.
I did it on 2 asus p5ad2-e premium boards, they both crash the same way.
