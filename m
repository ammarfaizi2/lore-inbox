Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRBXTWl>; Sat, 24 Feb 2001 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129570AbRBXTWb>; Sat, 24 Feb 2001 14:22:31 -0500
Received: from [213.96.124.18] ([213.96.124.18]:26607 "HELO dardhal")
	by vger.kernel.org with SMTP id <S129569AbRBXTWO>;
	Sat, 24 Feb 2001 14:22:14 -0500
Date: Sat, 24 Feb 2001 20:23:48 +0000
From: José Luis Domingo López 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Loop device hang
Message-ID: <20010224202347.A2771@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A97F1B1.109432F8@rochester.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A97F1B1.109432F8@rochester.rr.com>; from mbratche@rochester.rr.com on Sat, Feb 24, 2001 at 12:38:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 24 February 2001, at 12:38:57 -0500,
Mark Bratcher wrote:

> Has the loop device hang problem that was in kernel 2.4.0 been fixed in
> 2.4.1 or 2.4.2?
> 
Tried on 2.4.1 and 2.4.2 with different results: on 2.4.1 I've had no
problem mounting loop devices, but creating filesystems on them "hangs" the
machine (networking seems to be up for example, but remote login via ssh
doesn't work). Under 2.4.2 I've been unable to use loopback devices, but
AFAIK this is a known issue in this release.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

