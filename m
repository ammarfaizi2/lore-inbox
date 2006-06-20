Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWFTWuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWFTWuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWFTWuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:50:51 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:45464 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751463AbWFTWuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:50:50 -0400
From: "Jeff Anderson-Lee" <jonah@eecs.berkeley.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [RFC] suggestion [PATCH N/M] subject lines
Date: Tue, 20 Jun 2006 15:50:48 -0700
Message-ID: <000001c694bb$f9fa3f40$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcaUu/lE+0Bb57K9TCqTYaimFAY0kQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the mailing list with a non-threads compatible 
mail client agent would be made much easier if the 
convention for subject lines for multi-part patches was 
changed to the following:

	patch set name [PATCH N/M] patch summary

Then sorting by subject would group all patches for the
Same patch set together.

I don't know if these Subject lines are hand generated, or if there
is software involved that would have to me modified for generating
and/or parsing them.

Comments?

Jeff Anderson-Lee

