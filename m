Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263767AbTDNWAi (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263768AbTDNWAi (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:00:38 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:1164 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S263767AbTDNWAh (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:00:37 -0400
Date: Mon, 14 Apr 2003 15:11:10 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdevt-diff
Message-ID: <20030414221110.GK4917@ca-server1.us.oracle.com>
References: <UTC200304142201.h3EM19S07185.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304142201.h3EM19S07185.aeb@smtp.cwi.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 12:01:09AM +0200, Andries.Brouwer@cwi.nl wrote:
> > Do all devices smaller than 16:16 appear the same on all
> > filesystems, limited or not?
> 
> Yes.

	I meant "is that the behavior we want to choose?"  I understand
that this would be the result of your current scheme.
	I guess I'm wondering what made you choose "consistency across
legacy filesystems" over "consistency across our expanded device space".

Joel

-- 

Life's Little Instruction Book #444

	"Never underestimate the power of a kind word or deed."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
