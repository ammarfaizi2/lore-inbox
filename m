Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273001AbTHFAa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273002AbTHFAa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:30:57 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:63908
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S273001AbTHFAa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:30:56 -0400
Date: Tue, 5 Aug 2003 20:30:54 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: hsdm <hsdm@hsdm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it possible to add this feature.
Message-ID: <20030806003054.GN6541@kurtwerks.com>
References: <3F3049D0.6040804@hsdm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3049D0.6040804@hsdm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth hsdm:
> Is it posible to limit the amount of memory or CPU time per user?

ulimit -m
ulimit -t

Kurt
-- 
As long as the answer is right, who cares if the question is wrong?
