Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUBFRPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbUBFRPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:15:44 -0500
Received: from mail2.fw-sj.sony.com ([160.33.82.69]:53198 "EHLO
	mail2.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S265532AbUBFRPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:15:41 -0500
Message-ID: <4023CDAC.3080807@am.sony.com>
Date: Fri, 06 Feb 2004 09:23:56 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jw schultz <jw@pegasys.ws>
Subject: Re: [PATCH 2.6.2] Documentation/SubmittingPatches
References: <20040205072303.BCF79FA5F1@mrhankey.megahappy.net>	<20040206034509.GI21479@pegasys.ws> <20040205201309.4dac8b8c.rddunlap@osdl.org>
In-Reply-To: <20040205201309.4dac8b8c.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 5 Feb 2004 19:45:09 -0800 jw schultz <jw@pegasys.ws> wrote:

> It would be _great_ if the Documentation was more accurate to the
 > taste of developers/maintainers...

> | > --- linux-2.6.2/Documentation/SubmittingPatches.orig    2004-02-04 22:57:55.818563016 -0800
> | > +++ linux-2.6.2/Documentation/SubmittingPatches 2004-02-04 23:01:28.799185040 -0800
> | > @@ -33,13 +33,15 @@

I thought the preferred method was:

--- linux-2.6.2.orig/Documentation/SubmittingPatches
+++ linux-2.6.2/Documentation/SubmittingPatches

In other words, I always thought you should have a whole parallel
original tree.  This more nicely captures multi-file changes, IMHO, and
I've seen this a great deal.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

