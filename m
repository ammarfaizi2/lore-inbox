Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268158AbUHQIce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268158AbUHQIce (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268162AbUHQIcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:32:08 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42187 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268158AbUHQI3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:29:17 -0400
Subject: Re: typos
From: Lee Revell <rlrevell@joe-job.com>
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1092730251.18997.16.camel@gollum.tnic>
References: <1092730251.18997.16.camel@gollum.tnic>
Content-Type: text/plain
Message-Id: <1092731414.1859.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 04:30:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 04:10, Borislav Petkov wrote:
> Hi there guys,
> I've been pondering on posting about this for a long time but I guess
> I'll just go and say it. I've been reading the lkml for about a year now
> and, I don't know how important it is to you, but I think that typos in
> the comments in the kernel sources really annoy those who really read
> them in order to understand what's going on. Well, I'm one of them, and,
> since the typos are really a lot, I thought that maybe fixing them would
> be a good idea.
> Here's a patch. Please, tell me if you don't want such noise on the list
> but I think that, although not crucial, somewhat correct english in the
> comments would be better, or?
> 
> Regards,
> Boris
> 
> 

--- foo.orig	2004-08-17 04:27:55.000000000 -0400
+++ foo.fixed	2004-08-17 04:29:27.000000000 -0400
@@ -44,11 +44,11 @@
 and, I don't know how important it is to you, but I think that typos in
 the comments in the kernel sources really annoy those who really read
 them in order to understand what's going on. Well, I'm one of them, and,
-since the typos are really a lot, I thought that maybe fixing them would
+since there are really a lot of typos, I thought that maybe fixing them would
 be a good idea.
-Here's a patch. Please, tell me if you don't want such noise on the list
-but I think that, although not crucial, somewhat correct english in the
-comments would be better, or?
+Here's a patch. Please, tell me if you don't want such noise on the
+list.  I think that, although not crucial, somewhat more correct english in the
+comments would be better.
 
 Regards,
 Boris


