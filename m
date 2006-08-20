Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751652AbWHTWVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbWHTWVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWHTWVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:21:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:33170 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751652AbWHTWVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:21:19 -0400
Subject: Re: question on pthreads
From: Lee Revell <rlrevell@joe-job.com>
To: Luka Marinko <luka.marinko@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ecakcv$m06$1@sea.gmane.org>
References: <3420082f0608201046q53bb60b5u5ca8915e588ee9e3@mail.gmail.com>
	 <ecakcv$m06$1@sea.gmane.org>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 18:21:26 -0400
Message-Id: <1156112486.10565.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 21:32 +0000, Luka Marinko wrote:
> You can find nice manual here, and overview
> http://www.gnu.org/software/libc/manual/html_mono/libc.html
> 

Unfortunately the NPTL documentation is FAR from complete - there are no
man pages at all, and some featured are completely undocumented.  For
example process-shared mutexes are supported, but the only way you'd
know is to look at the source.  The only docs I could find on how to use
them were old Solaris man pages.

Lee

