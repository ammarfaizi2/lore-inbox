Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUGTHsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUGTHsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 03:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUGTHsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 03:48:16 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:52626 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S264213AbUGTHsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 03:48:14 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: 2.6.8-rc2-bk1: selinux won't compile
Date: Tue, 20 Jul 2004 07:48:14 +0000 (UTC)
Organization: Cistron
Message-ID: <cdiinu$ous$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1090309694 25564 62.216.30.38 (20 Jul 2004 07:48:14 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

security/selinux/hooks.c: In function `selinux_bprm_apply_creds':
security/selinux/hooks.c:1898: error: `PER_CLEAR_ON_SETID' undeclared (first use in this functio
security/selinux/hooks.c:1898: error: (Each undeclared identifier is reported only once
security/selinux/hooks.c:1898: error: for each function it appears in.)

Danny
-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

