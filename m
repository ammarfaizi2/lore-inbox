Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVETSUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVETSUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVETSUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:20:37 -0400
Received: from smtpauth.newman.easystreet.com ([206.102.12.11]:41599 "EHLO
	smtpauth.easystreet.com") by vger.kernel.org with ESMTP
	id S261181AbVETSUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:20:34 -0400
From: "ted creedon" <tcreedon@easystreet.com>
Cc: <openafs-info@openafs.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Date: Fri, 20 May 2005 11:20:29 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVdYd67kFCm2Q+5RIaEQ0JGYjxiuQABkSAg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <Pine.LNX.4.62.0505201915320.5473@tassadar.physics.auth.gr>
Message-Id: <20050520182030.3AD68B03C@smtpauth.easystreet.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a new kernel was built, what was it named?

Looks like the existing kernel was overwritten. Normally the
CONIFG_LOCALVERSION is changed to differentiate from a working kernel. (I.e.
if the new kernel fails one can reboot with an existing stable kernel).
tedc

