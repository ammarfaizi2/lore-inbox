Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTB0UTt>; Thu, 27 Feb 2003 15:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTB0UTt>; Thu, 27 Feb 2003 15:19:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46735 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266939AbTB0UTs>;
	Thu, 27 Feb 2003 15:19:48 -0500
Date: Thu, 27 Feb 2003 12:13:02 -0800 (PST)
Message-Id: <20030227.121302.86023203.davem@redhat.com>
To: bcollins@debian.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       ak@suse.de, arnd@bergmann-dalldorf.de
Subject: Re: ioctl32 consolidation -- call for testing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030227202739.GO21100@phunnypharm.org>
References: <20030226222606.GA9144@elf.ucw.cz>
	<20030227195135.GN21100@phunnypharm.org>
	<20030227202739.GO21100@phunnypharm.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Collins <bcollins@debian.org>
   Date: Thu, 27 Feb 2003 15:27:39 -0500
   
   Here it is. Sparc64's macros for ioctl32's assumed that cmd was u_int
   instead of u_long. This look ok to you, Dave?

We would love to see that patch :-)
