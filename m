Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753698AbWKFRzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbWKFRzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753700AbWKFRzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:55:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753691AbWKFRzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:55:20 -0500
Date: Mon, 6 Nov 2006 12:55:15 -0500
From: Dave Jones <davej@redhat.com>
To: Eric Anholt <eric@anholt.net>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: Resubmit: Intel 965 Express AGP patches
Message-ID: <20061106175515.GC19283@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk
References: <115747785570-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115747785570-git-send-email-eric@anholt.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 10:37:32AM -0700, Eric Anholt wrote:
 > The following should be the updated patch series for the Intel 965 Express
 > support, unless I'm making some mistake with git-send-email.  I think I've
 > covered Dave's concerns, except for making the PCI ID stuff table-driven.  You
 > can find a patch for that on the intel-agp-i965 branch at
 > git://anongit.freedesktop.org/~anholt/linux-2.6

Hmm, now that this is merged, crawlies are coming out of the woodwork..
http://bugzilla.kernel.org/show_bug.cgi?id=7464

	Dave

-- 
http://www.codemonkey.org.uk
