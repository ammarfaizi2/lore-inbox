Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWISNEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWISNEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 09:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbWISNEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 09:04:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9877 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030236AbWISNEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 09:04:04 -0400
Date: Tue, 19 Sep 2006 14:04:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>
Subject: Re: [PATCH 1/11] LTTng-core 0.5.111 : Relay+DebugFS (DebugFS fix)
Message-ID: <20060919130400.GA15796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Karim Yaghmour <karim@opersys.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
	Michel Dagenais <michel.dagenais@polymtl.ca>,
	Douglas Niehaus <niehaus@eecs.ku.edu>
References: <20060916075103.GB29360@Krystal> <450DF48B.3090205@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450DF48B.3090205@opersys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 09:21:15PM -0400, Karim Yaghmour wrote:
> 
> Mathieu Desnoyers wrote:
> > 1 - DebugFS stalled dentry patch
> 
> I think it would be best if patches posted were in the body of
> the email instead of as attachments. It makes it easier to
> review and comment.

Also the subject line is utterly useless.  Please take a look at
Documentation/SubmittingPatches for the general format of a patch.
> 
> Thanks,
> 
> Karim
> -- 
> President  / Opersys Inc.
> Embedded Linux Training and Expertise
> www.opersys.com  /  1.866.677.4546
---end quoted text---
