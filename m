Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTBYJZc>; Tue, 25 Feb 2003 04:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267877AbTBYJZc>; Tue, 25 Feb 2003 04:25:32 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19470 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267871AbTBYJZc>; Tue, 25 Feb 2003 04:25:32 -0500
Date: Tue, 25 Feb 2003 09:35:44 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] uart_block_til_ready 2.5.63
Message-ID: <20030225093544.B9257@flint.arm.linux.org.uk>
Mail-Followup-To: Ed Tomlinson <tomlins@cam.org>,
	linux-kernel@vger.kernel.org
References: <200302242142.26124.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302242142.26124.tomlins@cam.org>; from tomlins@cam.org on Mon, Feb 24, 2003 at 09:42:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 09:42:25PM -0500, Ed Tomlinson wrote:
> Feb 24 21:14:44 oscar kernel: Code: f6 80 1c 01 00 00 02 75 2d 8b 4d 08 51 e8 10 6e 00 00 85 c0

Can someone decode this Code: line into something useful please?
(maybe we should put in an instruction decoder as well as kallsyms
into the kernel? 8))

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

