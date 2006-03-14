Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWCNUIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWCNUIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCNUIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:08:31 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:10662
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751352AbWCNUIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:08:30 -0500
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: Mounting /dev/loop0: Device or resource busy
Date: Tue, 14 Mar 2006 15:08:53 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141508.53504.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why can I mount most block devices multiple times, but when I try to mount a 
loop device more than once under 2.6.16-rc5 it tells me it's busy?

This used to work...

Rob
-- 
Never bet against the cheap plastic solution.
