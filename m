Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbTELPoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTELPod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:44:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:25871 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262219AbTELPod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:44:33 -0400
Date: Mon, 12 May 2003 16:56:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030512165651.A3181@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Pollard <jesse@cats-chateau.net>,
	=?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200305081546_MC3-1-3809-363E@compuserve.com> <03050908530400.11221@tabby> <20030509143715.GC16354@vestdata.no> <03051209192501.16618@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <03051209192501.16618@tabby>; from jesse@cats-chateau.net on Mon, May 12, 2003 at 09:19:25AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 09:19:25AM -0500, Jesse Pollard wrote:
> All of the HSM systems I've used had the XDSM handled outside the kernel.

You obviously didn't look at the XFS dmapi implementation :)

