Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUGBTLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUGBTLo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264853AbUGBTLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:11:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17879 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264843AbUGBTLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:11:43 -0400
Subject: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
From: Dan Williams <dcbw@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Content-Type: text/plain
Date: Fri, 02 Jul 2004 15:11:38 -0400
Message-Id: <1088795498.18039.25.camel@dcbw.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is simply the fixed-up diff between the kernel's current
0.13e version and the upstream 0.15rc1+ version from savannah CVS.
0.15rc1 has been out for a couple months now and seems stable.

The major benefits that this newer version brings are, of course, many
bugfixes, but best of all wireless scanning support for the Orinoco line
of cards.

http://people.redhat.com/dcbw/linux-2.6.7-orinoco.patch.bz2

Dan Williams
Red Hat, Inc.

