Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSEaTzI>; Fri, 31 May 2002 15:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSEaTzH>; Fri, 31 May 2002 15:55:07 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:58752 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316971AbSEaTzG>; Fri, 31 May 2002 15:55:06 -0400
Date: Fri, 31 May 2002 22:00:41 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Sorry, I was wrong
Message-ID: <3CF7D669.mail9VB1DA5LZ@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello Alan & Thomas :)

    Effectively, the SuS says that mmap never place a map at address
0 nor affect an existing mapping *except* when called with MAP_FIXED.

    I didn't notice that point. Alan is right then.

    Raúl
