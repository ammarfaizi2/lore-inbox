Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVINW2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVINW2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVINW2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:28:44 -0400
Received: from smtp06.web.de ([217.72.192.224]:63878 "EHLO smtp06.web.de")
	by vger.kernel.org with ESMTP id S1030246AbVINW2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:28:23 -0400
From: Thomas Maguin <T.Maguin@web.de>
Reply-To: T.Maguin@web.de
To: linux-kernel@vger.kernel.org
Subject: cdrecord: Operation not permitted. Cannot send SCSI cmd via ioctl
Date: Thu, 15 Sep 2005 00:28:22 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509150028.24344.T.Maguin@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I try to burn as a normal user with cdrtools-2.01.01_alpha03 (from April 
2005) I get this error message and the commando terminates. 
cdrecord: Operation not permitted. Cannot send SCSI cmd via ioctl

Burning as root is working properly. 2.01.01_alpha01 is working for users.
linux 2.6.12-love
linux-2.6.13-gvivid

-------------------------------------------------------------------------------------------
Please Linus, go and buy a cd-recorder, and feel what we feel - again and 
again.
