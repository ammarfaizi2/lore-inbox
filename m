Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUIVEXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUIVEXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 00:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIVEXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 00:23:41 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:25234 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S267851AbUIVEXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 00:23:37 -0400
Subject: Re: Does ZONE_HIGHMEM exist on machines with 1G memeory
From: Aaron Gyes <floam@sh.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 21 Sep 2004 21:23:35 -0700
Message-Id: <1095827015.1490.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch by Con Kolivas well let you get the entire 1GB without
enabling and getting the overhead of HIGHMEM.

http://ck.kolivas.org/patches/2.6/2.6.9/2.6.9-rc2/2.6.9-rc2-ck2/patches/1g_lowmem1_i386.diff

--Aaron Gyes

