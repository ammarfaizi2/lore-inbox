Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVLNDFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVLNDFn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVLNDFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:05:43 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:49942 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030281AbVLNDFm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:05:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ndS1dy4qZSmEa23QY8tfzstMgvtS/j8u12Kf/y0k2D/Zuik7UIPbmJyzHbC8BoKI9CgYchgBgAqfSELIlDRt/WCekGXNrzKW3dmPLR+DratVcnUwW8hosHOaEK6hYXOqY3JXEsyPZ0tJlUZALc+KtmTtL4yVQidBaB8GC2dgyc0=
Message-ID: <2cd57c900512131905s1312047dy@mail.gmail.com>
Date: Wed, 14 Dec 2005 11:05:41 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: bugs?
Cc: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051214024316.GG15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <439F79CE.6040609@ens.etsmtl.ca>
	 <20051214024316.GG15993@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/14, Willy Tarreau <willy@w.ods.org>:
> On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
> > my cpu is 1400MHz, but why there's cpu MHz         : 598.593
> >
> > caro@olymphe:~$ cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 9
> > model name      : Intel(R) Pentium(R) M processor 1400MHz
> > stepping        : 5
> > cpu MHz         : 598.593
> > cache size      : 1024 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 2
> > wp              : yes
> > flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
> > pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
> > bogomips        : 1186.66
>
> It's probably a notebook that you started unplugged from the mains power.
> Mine is stupid enough to believe that I *want* to save power if I plug
> the mains *after* powering it up ! And there's no way to force it to
> switch from 600 to nominal freq afterwards ! So I have to connect it to

Isn't there a daemon to do that?

> the mains first.

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
