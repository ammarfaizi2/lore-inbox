Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSD3UDN>; Tue, 30 Apr 2002 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315203AbSD3UDM>; Tue, 30 Apr 2002 16:03:12 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:62726 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315202AbSD3UDL>; Tue, 30 Apr 2002 16:03:11 -0400
Date: Tue, 30 Apr 2002 21:03:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre7aa3
Message-ID: <20020430210304.Q26943@flint.arm.linux.org.uk>
In-Reply-To: <20020430203154.B11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 08:31:54PM +0200, Andrea Arcangeli wrote:
> Only in 2.4.19pre7aa2: 00_get_pid-no-deadlock-and-boosted-2
> Only in 2.4.19pre7aa3: 00_get_pid-no-deadlock-and-boosted-3
> 
> 	s/set_pid/__set_pid/ noticed by Russell King.

s/set_pid/set_bit/g

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

