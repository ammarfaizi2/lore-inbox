Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUCPOUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbUCPOSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:18:37 -0500
Received: from law9-f22.law9.hotmail.com ([64.4.9.22]:29189 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261850AbUCPOIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:08:45 -0500
X-Originating-IP: [202.9.130.118]
X-Originating-Email: [pushkaragashe@hotmail.com]
From: "vijay agashe" <pushkaragashe@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Active defragmentation : A replacement for bigphysarea?
Date: Tue, 16 Mar 2004 14:08:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law9-F22mEoxWAE1EHA00021cd6@hotmail.com>
X-OriginalArrivalTime: 16 Mar 2004 14:08:37.0666 (UTC) FILETIME=[2D388020:01C40B60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have implemented a memory defragmentation utility for linux kernel 2.6 
based on the paper by Mr. Daniel Phillips.
Can this utility be used instead of bigphysarea patch for requirements less 
than MAX_ORDER of allocation ?
Can the people using bigphysarea patch kindly provide me with their 
respective memory requirements.

Pushkar.

_________________________________________________________________
Protect your PC from viruses. Get in the experts. 
http://www.msn.co.in/pcsafety/ Click here now!

