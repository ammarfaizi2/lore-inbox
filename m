Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTDNRiY (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTDNRiY (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:38:24 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:59783 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S263587AbTDNRiX (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:38:23 -0400
Date: Mon, 14 Apr 2003 10:48:18 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-ID: <20030414174818.GR4917@ca-server1.us.oracle.com>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030412180852.77b6c5e8.akpm@digeo.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
> . I've changed the 32-bit dev_t patch to provide a 12:20 split rather than
>   16:16.  This patch is starting to drag a bit and unless someone stops me I
>   might just go submit the thing.

	Cool, but before you go off and push, maybe kick the appropriate
folks about making the 32/64 decision?

Joel

-- 

"When choosing between two evils, I always like to try the one
 I've never tried before."
        - Mae West

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
