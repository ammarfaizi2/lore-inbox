Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWD0Vl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWD0Vl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbWD0Vl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:41:56 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:63108 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751708AbWD0Vl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:41:56 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Date: Fri, 28 Apr 2006 07:41:52 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <jmd2529m892ln9h8ptpp58ltq5895495nb@4ax.com>
References: <20060427014141.06b88072.akpm@osdl.org> <p73vesv727b.fsf@bragg.suse.de> <20060427121930.2c3591e0.akpm@osdl.org>
In-Reply-To: <20060427121930.2c3591e0.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2006 12:19:30 -0700, Andrew Morton <akpm@osdl.org> wrote:

>I don't like dropping patches.  Because then the thing needs to be fixed up
>and resent and remerged and re-reviewed and rejects need to re-fixed-up and
>this adds emailing overhead and 12-24 hour turnaround, etc.  I very much
>prefer to hang onto the patch and get it fixed up.  This means that I
>usually have to do the fixing-up.

Perhaps dropping patches with obvious faults with some feedback 
to submitter may reduce your workload ;)  And is slowing down the 
merge a little in these cases such a bad thing if it improves 
patch quality over time?

Grant.
