Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTKLPIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTKLPHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:07:47 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:15807 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262195AbTKLPHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:07:38 -0500
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl> <3FAE9026.60500@stesmi.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Nov 2003 16:07:13 +0100
In-Reply-To: <3FAE9026.60500@stesmi.com>
Message-ID: <m3ekwd8w2m.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski <stesmi@stesmi.com> writes:

> And then someone comes along and says that feature X isn't working in
> some version. He then reports that "it worked in a.b.c but then someone
> broke it for a.b.c+1 pre 1. Then you have to tell that person that
> a.b.c+1 pre 1 isn't newer than a.b.c. Messy. Very messy.

I think people using testing/ kernels are able to learn such things.
-- 
Krzysztof Halasa, B*FH
