Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWCLVai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWCLVai (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWCLVag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:30:36 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:42513 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1750939AbWCLVaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:30:24 -0500
Message-Id: <20060312192259.929734000@mercator.sirena.org.uk>
Date: Sun, 12 Mar 2006 19:22:59 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Tim Hockin <thockin@hockin.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 0/4] natsemi: Aculab E1/T1 PMXc Carrier Card support
X-Spam-Score: -2.5 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  This patch series against the upstream branch of
	netdev-2.6 adds support for these boards to the natsemi driver. It
	implements some new functionality required by the boards and enables
	the appropriate settings when such a board is detected. [...] 
	Content analysis details:   (-2.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series against the upstream branch of netdev-2.6 adds support
for these boards to the natsemi driver.  It implements some new
functionality required by the boards and enables the appropriate
settings when such a board is detected.

--
"You grabbed my hand and we fell into it, like a daydream - or a fever."
