Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271074AbUJVKuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271074AbUJVKuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbUJVKuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:50:04 -0400
Received: from holomorphy.com ([207.189.100.168]:51137 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271074AbUJVKtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:49:21 -0400
Date: Fri, 22 Oct 2004 03:49:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
Message-ID: <20041022104917.GM17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 09:58:26PM -0700, Christoph Lameter wrote:
> Changelog
> 	* overcommit handling
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

I can make this out, but this probably actually needs to be presented
in slow motion so more than the two of us and its original authors can
work on it (and so I don't forget everything about it in 12-18 months).


-- wli
