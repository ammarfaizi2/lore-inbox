Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289455AbSBJJxs>; Sun, 10 Feb 2002 04:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSBJJxi>; Sun, 10 Feb 2002 04:53:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58895 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289366AbSBJJxU>; Sun, 10 Feb 2002 04:53:20 -0500
Date: Sun, 10 Feb 2002 09:53:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Tom Lord <lord@regexps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a new arch feature "for Linus"
Message-ID: <20020210095312.A12674@flint.arm.linux.org.uk>
In-Reply-To: <200202100913.BAA29987@morrowfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202100913.BAA29987@morrowfield.home>; from lord@regexps.com on Sun, Feb 10, 2002 at 01:13:15AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2002 at 01:13:15AM -0800, Tom Lord wrote:
> Not really only for Linus, but inspired by a feature he requested 
> of Bitkeeper on this list a few weeks ago.
> 
> The command is:
> 
> 	  % arch touched-files-prereqs REVISION

'arch' really isn't a good choice of command name:

$ which arch
/bin/arch
$ man arch

ARCH(1)             Linux Programmer's Manual             ARCH(1)

NAME
       arch - print machine architecture

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

