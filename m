Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVADSUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVADSUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVADSUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:20:20 -0500
Received: from [213.146.154.40] ([213.146.154.40]:37506 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261791AbVADSUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:20:12 -0500
Date: Tue, 4 Jan 2005 18:20:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050104182010.GA15254@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Jack O'Quin <joq@io.com>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104862614.8255.1.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 01:16:54PM -0500, Lee Revell wrote:
> Got a patch?  Code talks, BS walks.  This is working perfectly, right
> now, and is being used by thousands of Linux ausio users.

Which still doesn't mean it's the right design.  And no, I don't need the
feature so I won't write it.  If you want a certain feature it's up to
you to implement it in a way that's considered mergeable.

