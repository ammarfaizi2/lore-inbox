Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbTEMOAB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbTEMOAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:00:01 -0400
Received: from pointblue.com.pl ([62.89.73.6]:22799 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261250AbTEMOAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:00:00 -0400
Subject: [COMPILATION ERROR] 2.5.69-bk7 wireless.c:488: `THIS_MODULE'
	undeclared here
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1052834757.2268.13.camel@nalesnik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 May 2003 15:06:03 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/core/wireless.c:488: `THIS_MODULE' undeclared here (not in a
function)

this bug was added with -bk7 patch
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

