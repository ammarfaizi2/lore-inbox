Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUEHH51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUEHH51 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUEHH51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 03:57:27 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:21943 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S264176AbUEHH5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 03:57:19 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: (at home)
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: module-licences / tainting the kernel
Date: Sat, 8 May 2004 09:57:57 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405080957.57286.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

from my point of view, the 'tainting-rule' for kernel-modules is too 
restrictive, allowing GPL-only modules to not be marked as tainting the 
kernel.

Would it be possible to let e.g. LPGL-licenced kernel-modules be loaded 
legally?

I do not at all want to hide my source code in any way, but under some 
circumstances, the pure GPL is too restrictive, and would reduce interest in 
open-source projects significantly.

Opinions?

Regards,
			Axel


