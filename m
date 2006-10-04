Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161560AbWJDQbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161560AbWJDQbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161572AbWJDQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:31:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:58076 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161568AbWJDQbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:31:14 -0400
Message-Id: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.45-1
Date: Wed, 04 Oct 2006 17:26:10 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH 00/14] spufs/cell updates for 2.6.19
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finally updated the important patches for spufs to the powerpc.git
master branch. These include a number of changes to spufs, some of
which have been pending for a long time now.

Please merge them into 2.6.19.

	Arnd <><

--

