Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280486AbRJaUoA>; Wed, 31 Oct 2001 15:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280496AbRJaUnu>; Wed, 31 Oct 2001 15:43:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:12813 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280486AbRJaUnn>;
	Wed, 31 Oct 2001 15:43:43 -0500
Subject: Re: 2.4.14-pre6 + preempt dri lockup
From: Robert Love <rml@tech9.net>
To: safemode <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110312034.f9VKY1B01906@zero.tech9.net>
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org>
	<1004543705.1209.23.camel@phantasy> 
	<200110312034.f9VKY1B01906@zero.tech9.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 31 Oct 2001 15:44:23 -0500
Message-Id: <1004561064.1209.28.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-31 at 15:33, safemode wrote:
> I tried it with 2.4.13 without the preempt patch and it worked ...i have not 
> tried it without the preempt patch for 14, but since i'm not using the drm 
> that comes with it.  The only thing that i think could be it is the new 
> preempt patch.  I'm using the latest one you released for pre5.    Where is 
> the 2.4.14-pre2 preempt patch?  all i see is pre5.   

Cheat and guess the name :) It is at:
	http://tech9.net/rml/linux/preempt-kernel-rml-2.4.14-pre2-1.patch

I would appreciate it if you could apply that to 2.4.12-pre6 and see if
the problem repeats.

	Robert Love

