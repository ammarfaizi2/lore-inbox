Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSJIHqO>; Wed, 9 Oct 2002 03:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261415AbSJIHqO>; Wed, 9 Oct 2002 03:46:14 -0400
Received: from blueberrysolutions.com ([195.165.170.195]:38804 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S261398AbSJIHqN>; Wed, 9 Oct 2002 03:46:13 -0400
Date: Wed, 9 Oct 2002 10:51:50 +0300 (EEST)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: teg@blueberrysolutions.com
To: linux-kernel@vger.kernel.org
Subject: capable()-function
Message-ID: <Pine.LNX.4.44.0210091046230.30467-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was investigating problems with PCMCIA and found that
capable(CAP_SYS_ADMIN) returns always false in my case. If I'm calling
capable(CAP_SYS_ADMIN) as root - shouldn't it return true? What could
cause this? I'm using RH 8.0 and src-rpm of 2.4.18-14 kernel.

-- 
* Tony Glader 

