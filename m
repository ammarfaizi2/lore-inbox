Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314288AbSD0Q5V>; Sat, 27 Apr 2002 12:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314289AbSD0Q5U>; Sat, 27 Apr 2002 12:57:20 -0400
Received: from zero.tech9.net ([209.61.188.187]:47886 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314288AbSD0Q5U>;
	Sat, 27 Apr 2002 12:57:20 -0400
Subject: Re: The tainted message
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Richard Thrapp <rthrapp@sbcglobal.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 27 Apr 2002 12:57:08 -0400
Message-Id: <1019926629.2045.698.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-27 at 11:20, Alan Cox wrote:

> How about
> 
> Warning: The module you have loaded (%s) does not seem to have an open
> 	 source license. Please send any kernel problem reports to the
> 	 author of this module, or duplicate them from a boot without
> 	 ever loading this module before reporting them to the community
> 	 or your Linux vendor

Perfect.  A little long, but otherwise nails it.

Maybe we want to s/open source/GPL-compatible/ though?

	Robert Love

