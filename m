Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbULVQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbULVQEk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 11:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbULVQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 11:04:40 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:25104 "EHLO
	statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S262001AbULVQEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 11:04:39 -0500
Message-ID: <41C99AFA.4060108@s5r6.in-berlin.de>
Date: Wed, 22 Dec 2004 17:04:10 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux1394-devel@lists.sourceforge.net
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <1103544944.4133.7.camel@laptopd505.fenrus.org> <20041220132012.GA6046@localhost> <1103704157.4131.5.camel@laptopd505.fenrus.org> <41C9370C.1070905@s5r6.in-berlin.de> <20041222120153.GA10710@infradead.org>
In-Reply-To: <20041222120153.GA10710@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Dec 22, 2004 at 09:57:48AM +0100, Stefan Richter wrote:
>> ...which works best if submitters of patches remember to make use of the 
>> communication channels suggested in MAINTAINERS.
> Except when those are disfunct,

Correct, which is when MAINTAINERS needs to be updated.

> and hord their changes in CVS or SVN repositories..

An extra public repo is just a tool. Its effect depends on how skillful
it is used. But this is apriori unrelated to the consideration whether
to put a driver into mainline.
-- 
Stefan Richter
-=====-=-=-- ==-- =-==-
http://arcgraph.de/sr/
