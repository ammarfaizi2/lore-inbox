Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752463AbWKBVto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbWKBVto (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbWKBVto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:49:44 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51355 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752463AbWKBVtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:49:43 -0500
From: muli@il.ibm.com
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, muli@il.ibm.com,
       jdmason@kudzu.us
Subject: [PATCH 0/4] Calgary: updates for 2.6.20
Reply-To: muli@il.ibm.com
Date: Thu, 02 Nov 2006 23:49:36 +0200
Message-Id: <11625041803066-git-send-email-muli@il.ibm.com>
X-Mailer: git-send-email 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Please apply these four patches to your tree for 2.6.20. The first one
is trivial, second one is a bug fix for certain configuration of x460
(and in general replaces a hack with the Right Thing(TM), third is a
cleanup and fourth is mostly for the distros but also useful in
mainline. More details available with each patch.

Thanks,
Muli
