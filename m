Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWBCKRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWBCKRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWBCKRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:17:43 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:43942 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750893AbWBCKRn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:17:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cn0FS6fcWxtLdKiHgFesSzYScmMKEk655brrh2UDENAyzyuzIoARTteuIh8ktTSV+b7QJaG/c2xGKk/6z6TCJ8Y3gbeZUoY/hRmmB3NS+78Vyt8dZOu0+QVhjKpBSUtVibmWrgyVGjuQEG3cV2RHXefUtb9KNTZmRw75muN7m34=
Message-ID: <40f323d00602030217l77db3dd0o4f3f66eac74950f3@mail.gmail.com>
Date: Fri, 3 Feb 2006 11:17:39 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060203000704.3964a39f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/
>
>
> - The ntp/time rework patches from John Stultz have been resurrected and fixed.
>
> - There's now a `hot-fixes' directory at the above URL.  Please look in
>   there for any updates which should be applied.

It runs fine here, no problems. Even iptables works this time.

thanks

Benoit
