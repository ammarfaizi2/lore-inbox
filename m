Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVAELVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVAELVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVAELVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:21:07 -0500
Received: from [213.146.154.40] ([213.146.154.40]:41872 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262331AbVAELU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:20:59 -0500
Date: Wed, 5 Jan 2005 11:20:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050105112055.GC30954@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jack O'Quin <joq@io.com>, Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>
References: <1104374603.9732.32.camel@krustophenia.net> <20050103140359.GA19976@infradead.org> <1104862614.8255.1.camel@krustophenia.net> <20050104182010.GA15254@infradead.org> <87u0pxhvn0.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0pxhvn0.fsf@sulphur.joq.us>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 12:55:15PM -0600, Jack O'Quin wrote:
> Statements of the form "had I cared enough to do something about this
> problem, I would have implemented it differently" are not much help.
> This patch is small and clean.  It meshes with existing kernel LSM
> mechanisms.  It solves a real problem affecting many Linux desktop
> users.

It solves problems - most kernel patches do that.  But it does solve
this problems in a way that doesn't fit very well in the grand design.

