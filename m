Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTFHVir (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 17:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTFHVir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 17:38:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12814 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263952AbTFHVim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 17:38:42 -0400
Date: Sun, 8 Jun 2003 22:52:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Westwood <peter.westwood@talk21.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030608225217.F9520@flint.arm.linux.org.uk>
Mail-Followup-To: Peter Westwood <peter.westwood@talk21.com>,
	linux-kernel@vger.kernel.org
References: <000501c32e00$85d4f670$8200a8c0@coolermaster>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000501c32e00$85d4f670$8200a8c0@coolermaster>; from peter.westwood@talk21.com on Sun, Jun 08, 2003 at 09:57:04PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 09:57:04PM +0100, Peter Westwood wrote:
> 2601/tcp   open        zebra
> 2602/tcp   open        ripd
> Remote operating system guess: Linux Kernel 2.4.0 - 2.5.20
> Uptime 1.252 days (since Sat Jun 07 15:51:52 2003)
> Nmap run completed -- 1 IP address (1 host up) scanned in 13 seconds

zebra accepts telnet connections, and displays its version number on
connect.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

