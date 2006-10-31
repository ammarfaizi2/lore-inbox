Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423593AbWJaRMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423593AbWJaRMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423682AbWJaRMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:12:06 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:9743 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1423593AbWJaRMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:12:05 -0500
Date: Tue, 31 Oct 2006 18:12:04 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Cooling the cache
Message-ID: <20061031171204.GA8230@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to measure reliably some worst-case latencies, is there a way
to have the system (cleanly) drop as much as possible of its
page/directory cache?  Being able to specify which device would be a
plus ;-)

  OG.

