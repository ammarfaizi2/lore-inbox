Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWI1KR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWI1KR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWI1KR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:17:27 -0400
Received: from mail5.postech.ac.kr ([141.223.1.113]:44469 "EHLO
	mail5.postech.ac.kr") by vger.kernel.org with ESMTP
	id S1751674AbWI1KR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:17:26 -0400
Date: Thu, 28 Sep 2006 19:17:24 +0900
From: Seongsu Lee <senux@senux.com>
To: linux-kernel@vger.kernel.org
Subject: specifying the order of calling kernel functions (or modules)
Message-ID: <20060928101724.GA18635@pooky.senux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TERRACE-SPAMMARK: NO       (SR:3.11)                     
  (by Terrace)                                                   
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am a beginner of kernel module programming. I want to
specify the order of calling functions that I registered
by EXPORT_SYMBOL(). (or modules)

Thank you for your help.

-- 
Seongsu Lee - http://www.senux.com/
Buck-passing usually turns out to be a boomerang.




