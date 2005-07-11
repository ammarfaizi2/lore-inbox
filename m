Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVGKPm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVGKPm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGKPmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:42:49 -0400
Received: from compunauta.com ([69.36.170.169]:52140 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S262064AbVGKPmj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:42:39 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: linux-kernel@vger.kernel.org
Subject: PAGE_BUG macro
Date: Sun, 10 Jul 2005 23:47:32 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507102347.32388.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list, I have old code, and updating I see PAGE_BUG was gone, is fine to 
diable with a macro to allow build on old kernels?.

I see on old post PAGE_BUG and friends seems to be exterminated

#ifdef PAGE_BUG
....
....
#endif

:|

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
