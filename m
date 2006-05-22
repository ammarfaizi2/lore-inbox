Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWEVXtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWEVXtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWEVXtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 19:49:49 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:28330 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751316AbWEVXts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 19:49:48 -0400
Message-ID: <44724DE3.2000209@us.ibm.com>
Date: Mon, 22 May 2006 16:48:51 -0700
From: Mike Mason <mmlnx@us.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nmi_watchdog default setting on i386 and x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anybody know the reasoning behind having nmi_watchdog turned off by 
default on i386 and on by default on x86_64.  I've heard that i386 had 
problems with false positives in the past, but that local apic watchdog 
may make that concern obsolete.

Regards,
Mike Mason

