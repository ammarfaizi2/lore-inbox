Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWHBHP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWHBHP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWHBHP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:15:27 -0400
Received: from mail.digitec.de ([213.23.20.68]:55783 "EHLO mail.digitec.de")
	by vger.kernel.org with ESMTP id S1751292AbWHBHP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:15:27 -0400
From: Sven Anders <s.anders@digitec.de>
To: linux-kernel@vger.kernel.org
Subject: What happens if the klogd dies
Date: Wed, 2 Aug 2006 09:15:22 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020915.25369.s.anders@digitec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I wander what happens it the klog-daemon do not work. Will the kernel log 
messages stored somewere in the kernel-memory, or are they discarded?
Is it posible that, after a amount of time the kernel crash, bescause of that?

I could not find anything about this in the manpage of klogd or in the kernel 
documentation.

Thanks for your help

Sven Anders

(Im not subscribed to the list, but read the mailinglist-archive. So CCing is 
not nessasary, but welcome)
