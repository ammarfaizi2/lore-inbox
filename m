Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTEBWz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 18:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTEBWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 18:55:28 -0400
Received: from dialpool-210-214-82-182.maa.sify.net ([210.214.82.182]:128 "EHLO
	softhome.net") by vger.kernel.org with ESMTP id S263199AbTEBWz1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 18:55:27 -0400
Date: Sat, 3 May 2003 04:36:37 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: wrong screen size with fbcon [2.5.68]
Message-ID: <20030502230637.GA494@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-GPG-Fingerprint: A977 433E B71E 2D1C 6114  9F33 F390 527D 70D1 2799
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted about this when 2.5.68 was released but very few people 
responded.
While using the framebuffer console driver, I seems that the screen is 
set to something like 1024x775 instead of 1024x768. I cannot see the 
bottom of my screen that is...
I just checked the latest bk taken from kernel.org and still hasn't been 
fixed.
The fb console was working perfectly till 2.5.67.

If it is of any relevance, I'm using an nvidia tnt2 card. Has nobody 
noticed this problem?
-- 
