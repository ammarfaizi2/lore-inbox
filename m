Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUEFQfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUEFQfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEFQfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:35:51 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:47772 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261210AbUEFQdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:33:14 -0400
Date: Thu, 6 May 2004 17:32:06 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, pazke@donpac.ru,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: [RFC] DMI cleanup patches
Message-ID: <20040506163206.GB8430@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	pazke@donpac.ru, linux-kernel@vger.kernel.org,
	Dave Airlie <airlied@linux.ie>
References: <20040506102904.GA3295@pazke> <Pine.LNX.4.58.0405060738430.3271@ppc970.osdl.org> <20040506081012.6cb4ab2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506081012.6cb4ab2f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 08:10:12AM -0700, Andrew Morton wrote:

 > There is a significant amount of work pending in the DRM development tree
 > at http://drm.bkbits.net/drm-2.6 (which is included in -mm).  Andrey's
 > zeroeth patch alone tosses three rejects against it.

Why on earth is the DRM stuff touching the DMI code ?

		Dave

