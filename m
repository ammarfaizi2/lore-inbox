Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271118AbUJVLBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271118AbUJVLBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271183AbUJVLBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:01:24 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:2827 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271174AbUJVLBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:01:22 -0400
Date: Fri, 22 Oct 2004 12:01:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
Message-ID: <20041022110116.GA17699@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
	linux-kernel@vger.kernel.org
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:58:26PM -0700, Christoph Lameter wrote:
> Changelog
> 	* overcommit handling

overcommit for huge pages sounds like a realy bad idea.  Care to explain
why you want it?

