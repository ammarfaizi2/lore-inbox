Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269898AbRHJD1y>; Thu, 9 Aug 2001 23:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269900AbRHJD1o>; Thu, 9 Aug 2001 23:27:44 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:23745 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S269898AbRHJD12>; Thu, 9 Aug 2001 23:27:28 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200108100327.EAA22951@mauve.demon.co.uk>
Subject: Network device aliases
To: linux-kernel@vger.kernel.org (l)
Date: Fri, 10 Aug 2001 04:27:29 +0100 (BST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've more or less worked out how network devices are initiated,
and configured, with the help of the htmlised sources, but am not
finding anything on how aliases (eth0:1 ...) work.
Do they have an entire device structure that only differs in name and
IP address?
Any pointers would be most welcome.
Many thanks.
