Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbTEBMKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 08:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbTEBMKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 08:10:45 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:38143 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S262021AbTEBMKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 08:10:44 -0400
Date: Fri, 2 May 2003 14:22:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390: descriptions.
Message-ID: <20030502122214.GA6110@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
3 patches for s390, just minor stuff. Arnd is working on the compat ioctls
which are broken for s390 right now, and we have started working on the 3270
driver which is in a bad shape.

Short descriptions:
1) Various s390 bug fixes. 
2) Optimze s390 inline assemblies.
3) Remove remaining MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT pairs from s390 code.

blue skies,
  Martin.

-- 
blue skies,
  Martin.

