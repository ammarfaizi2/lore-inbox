Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbSIRH1c>; Wed, 18 Sep 2002 03:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265829AbSIRH1c>; Wed, 18 Sep 2002 03:27:32 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:18378 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S265711AbSIRH1c>; Wed, 18 Sep 2002 03:27:32 -0400
Message-ID: <3D88DC86.234B0346@toughguy.net>
Date: Wed, 18 Sep 2002 13:05:26 -0700
From: Bourne <bourne@toughguy.net>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: identifying tasks with opened sockets
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

Is there any way/means of realibly knowing that the 'current' task has
opened sockets for network communication ? I need to capture this info
in kernel space.

Pls help.

-- 
The art of life is drawing sufficient conclusions from insufficient
premises
