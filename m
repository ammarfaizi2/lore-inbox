Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265791AbTAXVvZ>; Fri, 24 Jan 2003 16:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265798AbTAXVvZ>; Fri, 24 Jan 2003 16:51:25 -0500
Received: from rth.ninka.net ([216.101.162.244]:57516 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265791AbTAXVvY>;
	Fri, 24 Jan 2003 16:51:24 -0500
Subject: Re: [PATCH] to support hookable flush_tlb* functions
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       schulz@uni-mannheim.de
In-Reply-To: <20030124132136.765a420d.akpm@digeo.com>
References: <1043418252.3e314c8d0278a@rumms.uni-mannheim.de> 
	<20030124132136.765a420d.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Jan 2003 14:39:22 -0800
Message-Id: <1043447962.16486.17.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-24 at 13:21, Andrew Morton wrote:
> Well the big questions are: where are the drivers for these devices?

Andrew, have a look at:

http://www.dolphinics.com/support/os/source.html

it is possibly the most popular example.

