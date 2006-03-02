Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWCBJUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWCBJUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWCBJUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:20:51 -0500
Received: from us02smtp1.synopsys.com ([198.182.60.75]:36335 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S932150AbWCBJUu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:20:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Getting CPU Usage of a running child process
Date: Thu, 2 Mar 2006 14:50:41 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE9596587@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: Getting CPU Usage of a running child process
Thread-Index: AcY92pPSyN42OXgfQIad3rhpQJCOmw==
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Mar 2006 09:20:46.0234 (UTC) FILETIME=[966A1FA0:01C63DDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The times() function gets me the system/user CPU usage of me (invoking
process) and all my terminated/waited children.

Is there any User Space API/way for me (a process) to get the
system/user CPU usage of one of my currently running child process? Am
looking for a portable solution...not sure if there is any

Thanks,
Arijit
