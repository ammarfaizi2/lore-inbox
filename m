Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVBGWQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVBGWQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVBGWQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:16:45 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:3339 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261221AbVBGWQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:16:43 -0500
Date: Mon, 7 Feb 2005 23:16:38 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Irix NFS server usual problem
Message-ID: <20050207221638.GA18723@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm starting to install some fedora core 3 systems in an environment
where 64bits SGIs are still serving the home directories.  They have
the bug/feature that required the 2.4 patch to hack the 64bits
cookies[1].  The 2.6 kernel I just found still can't compensate by
itself for the issue.

Is there an easy way to fix that?

  OG.
