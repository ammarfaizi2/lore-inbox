Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSLMO7Z>; Fri, 13 Dec 2002 09:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSLMO7Z>; Fri, 13 Dec 2002 09:59:25 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:2944 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S264715AbSLMO7Y>;
	Fri, 13 Dec 2002 09:59:24 -0500
Message-ID: <3DF9F780.1070300@walrond.org>
Date: Fri, 13 Dec 2002 15:06:40 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Symlink indirection
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick question;

Is the number of allowed levels of symlink indirection (if that is the 
right phrase; I mean symlink -> symlink -> ... -> file) dependant on the 
kernel, or libc ? Where is it defined, and can it be changed?

TIA
Andrew

