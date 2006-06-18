Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWFRH0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWFRH0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFRH0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:26:20 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:53902 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751115AbWFRH0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:26:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [ckpatch][0/29] 2.6.17-ck1 patches
Date: Sun, 18 Jun 2006 17:26:16 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1235
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606181726.16426.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the patch queue for the patches going into 2.6.17-ck1. Why? People 
have expressed interest in knowing what the heck all my patches are so I've 
added changelogs and am posting them for perusal.

These patches were designed to improve system responsiveness and interactivity 
_but_ are plagued with the fundamental problem that I do not have a way of 
measuring their effect and proving they help (except for better interbench 
results for the staircase cpu scheduler).

Except for the patches that are already in -mm, these patches are _not_ being 
pushed for mainline so please don't review them as such. The lack of some 
benchmark to prove they help means I won't pursue mainline inclusion since 
the abuse I'll get will probably kill me. Constructive comments, however, are 
most welcome :)

-- 
-ck
