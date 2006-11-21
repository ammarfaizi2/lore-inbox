Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966943AbWKUJwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966943AbWKUJwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966947AbWKUJwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:52:50 -0500
Received: from mail.innomedia.soft.net ([164.164.79.130]:51628 "EHLO
	gateway.innomedia.soft.net") by vger.kernel.org with ESMTP
	id S966943AbWKUJwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:52:50 -0500
Message-ID: <4562CCB2.1030400@innomedia.soft.net>
Date: Tue, 21 Nov 2006 15:23:54 +0530
From: Dipti Ranjan Tarai <dipti@innomedia.soft.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to read/write from/to the HD with out kernel cashing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
       I am using fedora core -3 with kernel 2.6.10. I want to 
read/write a sector from/to the HD with out kernel caching. Basically my 
aim is to communicate directly with the ide drivers so that I can bypass 
the kernel cache. Please give some idea regarding this.

Regards
Dipti Ranjan Tarai
