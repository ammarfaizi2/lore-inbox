Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUHEHL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUHEHL2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267581AbUHEHL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:11:28 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:54996 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S267583AbUHEHLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:11:00 -0400
To: linux-kernel@vger.kernel.org
Date: Thu, 05 Aug 2004 09:10:16 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2004.08.05.07.10.15.718214@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: pts/pty problem since 2.6.8-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Whenever I boot a kernel of the 2.6.8-* series (also -rc3) I cannot open
up any xterms in X. I first have to lsof /dev/pts and kill all the 1-5
processes listed there. Afterwards xterm etc pops up without problems.

Any ideas what could go wrong ?

Cheers,
Soeren.
