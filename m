Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317558AbSFMJKf>; Thu, 13 Jun 2002 05:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSFMJKb>; Thu, 13 Jun 2002 05:10:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35596 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317558AbSFMJK2>; Thu, 13 Jun 2002 05:10:28 -0400
Date: Thu, 13 Jun 2002 10:10:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Oliver Kropp <dok@directfb.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.19-pre10] CyberPro 32bit support and other fixes
Message-ID: <20020613101027.B24154@flint.arm.linux.org.uk>
In-Reply-To: <20020613083929.GA32366@skunk.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 10:39:29AM +0200, Denis Oliver Kropp wrote:
> this patch adds 32 bit support to cyber2000fb which is useful
> if you have a video layer in the background (CyberPro 5xxx) with
> per pixel alpha blending enabled.

... Same comments as the 2.5 version.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

