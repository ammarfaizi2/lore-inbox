Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbTE1Pou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbTE1Pou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:44:50 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:61825 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S264774AbTE1Pot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:44:49 -0400
Date: Wed, 28 May 2003 17:58:03 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.70 mmu_cr4_features
Message-ID: <20030528155803.GA1454@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I tried to correct a 'Missing mmu_cr4_features symbol' in the DRM
modules (in my case it's i810).

I've found this symbol only in i386 and x86_64 architectures...

For me this patch works fine.

Please, rewiev and apply...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
