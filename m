Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUG2Qsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUG2Qsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUG2QrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:47:21 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:42731 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S267572AbUG2Qpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:45:35 -0400
Subject: sys_symlink -EPERM
From: FabF <fabian.frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1091119520.2334.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 18:45:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	sys_symlink is returning permission error when fs isn't symlink
compliant.Wouldn't it be interesting to be more precise here ? If yes,
how don't break current userland appl. (eg ln)

Regards,
FabF

