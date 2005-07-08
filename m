Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVGHAl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVGHAl0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 20:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVGHAl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 20:41:26 -0400
Received: from mo.optusnet.com.au ([203.10.68.101]:12434 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP id S262392AbVGHAlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 20:41:24 -0400
To: Sheo Shanker Prasad <ssp@creativeresearch.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disturbing wide variation in execution time
References: <200507062344.53615.ssp@creativeresearch.org>
From: michael@optusnet.com.au
Date: 08 Jul 2005 10:41:54 +1000
In-Reply-To: <200507062344.53615.ssp@creativeresearch.org>
Message-ID: <m2fyuqt9gt.fsf@mo.optusnet.com.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sheo Shanker Prasad <ssp@creativeresearch.org> writes:
[...]
> When the repaired machine was started, I began to notice the disturbing wide 
> variation and the frequect significant slow down of the machine as exhibited 
> by the factor of 2 to 2.5 increased execution time of the test program as 
> described above.  Sometimes it would be quite fast (executing at the original 
> 2m 40s) and sometime a factor of 2.5 slow, and sometimes with speed in 
> between.

Something stuffed on the CPU heatsink causing thermal speed throttling?
Just a wild guess.

Michael.
