Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUJMFnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUJMFnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJMFnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:43:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50648 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267815AbUJMFnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:43:03 -0400
Subject: Re: Difference in priority
From: Lee Revell <rlrevell@joe-job.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Con Kolivas <kernel@kolivas.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       ankitjain1580@yahoo.com, Ingo Molnar <mingo@elte.hu>, rml@tech9.net
In-Reply-To: <416CB85A.7030309@osdl.org>
References: <1097542651.2666.7860.camel@cube>
	 <cone.1097626558.804486.12364.502@pc.kolivas.org>
	 <1097630263.2674.9508.camel@cube>
	 <1097643510.1553.120.camel@krustophenia.net>  <416CB85A.7030309@osdl.org>
Content-Type: text/plain
Message-Id: <1097645978.5879.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 01:39:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 01:08, Randy.Dunlap wrote:
> Lee Revell wrote:
> > On Tue, 2004-10-12 at 21:17, Albert Cahalan wrote:
> > 
> >>I can't see why the RT priority range would be increased.
> >>It's overkill already, especially since Linux doesn't have
> >>priority inheritance. Since POSIX requires 32 levels, that
> >>is the right number. Actually using more than one level
> >>(remember: NO priority inheritance) might not be wise.
> > 
> > 
> > Linux will probably have priority inheritance soon.  See the "Real Time
> > Kernel" thread.
> 
> Is that opinion based any on this article and Linus's comments in it?
> 
> http://news.com.com/A+new+direction+for+Linux+for+gadgets/2100-7344_3-5406291.html?tag=cd.top
> 

No, but priority inheritance is not the same as making Linux an RTOS.

Lee

