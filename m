Return-Path: <linux-kernel-owner+w=401wt.eu-S1753963AbWLRNFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbWLRNFo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbWLRNFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:05:44 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:1279 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963AbWLRNFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:05:43 -0500
Date: Mon, 18 Dec 2006 14:05:41 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Detecting disk I/O errors
Message-ID: <20061218130541.GA60506@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to know if there has been I/O error(s) on a specific
disk or partition since boot other than parsing dmesg and hoping it's
both still there and in the expected format?

Of course that's if the error didn't kill the system in the first
place :-)

  OG.

