Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVCUP07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVCUP07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVCUP07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:26:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:45759 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261373AbVCUP0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:26:51 -0500
Date: Mon, 21 Mar 2005 16:26:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Invalidating dentries
Message-ID: <Pine.LNX.4.61.0503211626180.20464@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


how can I invalidate all buffered/cached dentries so that ls -l /somefolder 
will definitely go read the harddisk?


Jan Engelhardt
-- 
