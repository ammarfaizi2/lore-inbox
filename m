Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWGZVdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWGZVdb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWGZVdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:33:31 -0400
Received: from [212.76.91.139] ([212.76.91.139]:54026 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751170AbWGZVda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:33:30 -0400
From: Al Boldi <a1426z@gawab.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp hangs on headless resume-from-ram
Date: Thu, 27 Jul 2006 00:34:47 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200607262206.48801.a1426z@gawab.com> <200607262207.46773.rjw@sisk.pl>
In-Reply-To: <200607262207.46773.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270034.47532.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday 26 July 2006 21:06, Al Boldi wrote:
> > swsusp is really great, most of the time.  But sometimes it hangs after
> > coming out of STR.  I suspect it's got something to do with display
> > access, as this problem seems hw related.  So I removed the display
> > card, and it positively does not resume from ram on 2.6.16+.
> >
> > Any easy fix for this?
>
> I have one idea, but you'll need a patch to test.  I'll try to prepare it
> tomorrow.
>
> I guess your box is an i386?

That should be assumed by default :)


Thanks for looking into this!


--
Al

