Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265497AbUEZLlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265497AbUEZLlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUEZLlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:41:45 -0400
Received: from mibi02.meb.uni-bonn.de ([131.220.21.3]:15364 "EHLO
	mibi02.meb.uni-bonn.de") by vger.kernel.org with ESMTP
	id S265497AbUEZLlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:41:44 -0400
Subject: Re: PROBLEM: Linux-2.6.6 with dm-crypt hangs on SMP boxes
From: "Dr. Ernst Molitor" <molitor@uni-bonn.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
       Christophe Saout <christophe@saout.de>,
       "Dr. Ernst Molitor" <molitor@uni-bonn.de>,
       "Dr. Ernst Molitor" <em@cfce.de>
In-Reply-To: <1085430830.7365.24.camel@felicia>
References: <1085043539.18199.20.camel@felicia>
	<20040521185640.6bf88bdb.akpm@osdl.org>  <1085430830.7365.24.camel@felicia>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 26 May 2004 13:41:31 +0200
Message-Id: <1085571692.16063.10.camel@mibi02>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux gurus, 

sorry having to say so: My 2.6.6bk8 test box, with kernel option
nolapic, died a few minutes ago, while printing a couple of pages on a
printer attached to it via USB. Currently, nolapic seems to alleviate,
but not cure the problem.

I'd happily try and do any check you might want to suggest to further
pinpoint the problem.

Best wishes and regards, 

Ernst

