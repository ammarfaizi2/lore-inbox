Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289415AbSAVWBW>; Tue, 22 Jan 2002 17:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289413AbSAVWBM>; Tue, 22 Jan 2002 17:01:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3341 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289415AbSAVWA5>; Tue, 22 Jan 2002 17:00:57 -0500
Date: Tue, 22 Jan 2002 22:00:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre6
Message-ID: <20020122220046.C21383@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.21.0201221602360.2059-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201221602360.2059-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Jan 22, 2002 at 04:06:38PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 04:06:38PM -0200, Marcelo Tosatti wrote:
> pre6:
> 
> - Removed patch in icmp code: its not needed 
>   and causes problems				(me)

Can you enlighten us as to why it is "not needed" ?  I haven't seen any
followups from Andi nor Davem to saying that.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

