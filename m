Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbRFCL1w>; Sun, 3 Jun 2001 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbRFCL1m>; Sun, 3 Jun 2001 07:27:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17427 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262873AbRFCL1g>; Sun, 3 Jun 2001 07:27:36 -0400
Subject: Re: [CHECKER] security rules?  (and 2.4.5-ac4 security bug)
To: engler@csl.Stanford.EDU (Dawson Engler)
Date: Sun, 3 Jun 2001 12:22:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200106030807.BAA02597@csl.Stanford.EDU> from "Dawson Engler" at Jun 03, 2001 01:07:37 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156VyD-0004D9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/random.c:1813:uuid_strategy: ERROR:RANGE:1809:1813: Using user length "len" as argument to "copy_to_user" [type=LOCAL] set by 'get_user':1813

Sigh I thought I had all of the sysctl ones
