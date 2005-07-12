Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVGLF6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVGLF6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 01:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVGLF6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 01:58:51 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:27282 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S262381AbVGLF6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 01:58:50 -0400
Subject: [BUG] Fusion MPT Base Driver initialization failure with kdump
From: Bharata B Rao <bharata@in.ibm.com>
Reply-To: bharata@in.ibm.com
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM
Date: Tue, 12 Jul 2005 11:26:49 +0530
Message-Id: <1121147809.10622.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fusion MPT base driver fails during initialization when kdump capture
kernel boots. The details of the problem are reported here:

http://bugzilla.kernel.org/show_bug.cgi?id=4870

Regards,
Bharata.

