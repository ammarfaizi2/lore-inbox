Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268012AbUHEWGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268012AbUHEWGa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268006AbUHEWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:05:51 -0400
Received: from mail44.e.nsc.no ([193.213.115.44]:53991 "EHLO mail44.e.nsc.no")
	by vger.kernel.org with ESMTP id S268005AbUHEWFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:05:09 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2-bk13 and later: Read-only filesystem on USB
From: Harald Arnesen <harald@skogtun.org>
Date: Fri, 06 Aug 2004 00:05:02 +0200
Message-ID: <87n01944xd.fsf@basilikum.skogtun.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to copy a file to my DataBar <www.data-bar.com> mounted at
/mnt/cf under 2.6.8-rc-2-bk13 or 2.6.8-rc3, I get the error "cp: cannon
stat `/mnt/cf/testfile': Permission denied". Same thing with a CF card
in an USB adapter.

It worked under 2.6.8-rc2-bk12 and earlier.
-- 
Hilsen Harald.
