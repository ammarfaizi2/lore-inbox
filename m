Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267701AbUI1NjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267701AbUI1NjP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267737AbUI1NjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 09:39:15 -0400
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:46230 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S267701AbUI1NjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 09:39:08 -0400
Date: Tue, 28 Sep 2004 15:39:06 +0200
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Ankit Jain <ankitjain1580@yahoo.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: processor affinity
Message-ID: <20040928133906.GC4926@hout.vanvergehaald.nl>
References: <20040928122517.9741.qmail@web52907.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928122517.9741.qmail@web52907.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 01:25:17PM +0100, Ankit Jain wrote:
> hi
> 
> what is meant by processor affinity?

$ man sched_setaffinity

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
