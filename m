Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285661AbRLGXmm>; Fri, 7 Dec 2001 18:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285670AbRLGXmc>; Fri, 7 Dec 2001 18:42:32 -0500
Received: from zero.tech9.net ([209.61.188.187]:5382 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S285661AbRLGXmP>;
	Fri, 7 Dec 2001 18:42:15 -0500
Subject: Re: Linux 2.4.17-pre6 drm-4.0
From: Robert Love <rml@tech9.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-ia64@linuxia64.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4719.1007767953@ocs3.intra.ocs.com.au>
In-Reply-To: <4719.1007767953@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 07 Dec 2001 18:42:10 -0500
Message-Id: <1007768531.12114.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-12-07 at 18:32, Keith Owens wrote:
> On 07 Dec 2001 18:27:11 -0500, Robert Love <rml@tech9.net> wrote:

> >For 2.5, there probably is no intention of keeping that around.  But can
> >we honestly ditch it in the middle of a stable kernel?  Personally I
> >don't use it, but its not polite ...

> Linus ditched drm 4.0 months ago.  It only survives in arch add on
> patches like ia64 and in -ac trees.

I know.  I meant we should continue to support the drm-4.0 package. 
It's the usual song ... we shouldn't change interfaces or required tools
in a stable series, and the least we can do is make 4.0 available
somehow, because someone may rely on it.

On the flip side, I don't care, and I suspect the people who actually
are using DRM are on 4.1 now.  Further, if _you_ are maintaining the
cruft and it bothers _you_, then stop :)

	Robert Love

