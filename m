Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbSJCRMf>; Thu, 3 Oct 2002 13:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261761AbSJCRMf>; Thu, 3 Oct 2002 13:12:35 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37895
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261759AbSJCRMe>; Thu, 3 Oct 2002 13:12:34 -0400
Subject: Re: O(1) scheduler for 2.4.(19|20-pre.)?
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1033647544.28022.2.camel@irongate.swansea.linux.org.uk>
References: <200210031148.23823.roy@karlsbakk.net> 
	<1033647544.28022.2.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 13:17:27 -0400
Message-Id: <1033665449.909.24.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 08:19, Alan Cox wrote:

> 2.4.19-ac/2.4.20-ac, Red Hat 7.3, Red Hat 8.0, and probably quite a
> few other places. I think Robert had a set of patches versus plain
> 2.4.19 too

Yep, see:

http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/

I would recommend using 2.4-ac over mainline with my patches, however. 
Alan's tree is well-tested and I send him scheduler fixes quicker than I
update my own patches :)

It has lots of other nice bits, too.

	Robert Love

