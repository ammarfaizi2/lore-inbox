Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbSJHQ0d>; Tue, 8 Oct 2002 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbSJHQ0d>; Tue, 8 Oct 2002 12:26:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34034 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261405AbSJHQ0d>;
	Tue, 8 Oct 2002 12:26:33 -0400
Message-ID: <3DA3087B.5080704@us.ibm.com>
Date: Tue, 08 Oct 2002 09:31:55 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Attempt to release TCP socket errors in 2.5.41
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running a certain large webserver benchmark on an 8-way 
Profusion-based PIII Xeon.  I'm using Apache2.  These errors have 
cropped up pretty recently, definitely since 2.5.34:
Attempt to release TCP socket in state 1 f1e3f440

-- 
Dave Hansen
haveblue@us.ibm.com

