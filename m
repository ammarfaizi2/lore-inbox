Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSJQQN1>; Thu, 17 Oct 2002 12:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSJQQN1>; Thu, 17 Oct 2002 12:13:27 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:37533 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261481AbSJQQN0>;
	Thu, 17 Oct 2002 12:13:26 -0400
Date: Thu, 17 Oct 2002 17:21:40 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: John Hesterberg <jh@sgi.com>
Cc: linux-kernel@vger.kernel.org, Robin Holt <holt@sgi.com>
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021017162140.GA26026@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Hesterberg <jh@sgi.com>, linux-kernel@vger.kernel.org,
	Robin Holt <holt@sgi.com>
References: <20021017102146.A17642@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017102146.A17642@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:21:47AM -0500, John Hesterberg wrote:
 > 2.5.43 versions of CSA, Job, and PAGG patches are available at:
 >     ftp://oss.sgi.com/projects/pagg/download/linux-2.5.43-pagg-job.patch
 >     ftp://oss.sgi.com/projects/csa/download/linux-2.5.43-csa.patch

The first two lines in the csa patch contain an obvious jiffy-wrap bug.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
