Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVIROur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVIROur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIROur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:50:47 -0400
Received: from [212.76.86.59] ([212.76.86.59]:58372 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751108AbVIROuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:50:46 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-assembly@vger.kernel.org
Subject: Fork capture
Date: Sun, 18 Sep 2005 17:48:40 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181748.40029.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a way to capture a process-fork?

Something like:
process/kModule A monitors procs for forking, captures it and manages further 
processing.

Thanks!

--
Al

