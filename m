Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVJSLyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVJSLyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVJSLyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:54:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750801AbVJSLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:54:42 -0400
Date: Wed, 19 Oct 2005 12:54:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, rmk@arm.linux.org.uk,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       andmike@us.ibm.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi_error thread exits in TASK_INTERRUPTIBLE state.
Message-ID: <20051019115435.GA31007@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lee Revell <rlrevell@joe-job.com>,
	Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, rmk@arm.linux.org.uk,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	andmike@us.ibm.com, linux-scsi@vger.kernel.org
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com> <1129693423.8910.54.camel@mindpipe> <1129695564.8910.64.camel@mindpipe> <Pine.LNX.4.58.0510190300010.20634@localhost.localdomain> <Pine.LNX.4.58.0510190349590.20634@localhost.localdomain> <20051019113131.GA30553@infradead.org> <Pine.LNX.4.58.0510190751070.20634@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510190751070.20634@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 07:51:47AM -0400, Steven Rostedt wrote:
> So, should I resend the patch without the comment?

yes, please ;-)

