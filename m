Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVGPMbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVGPMbU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 08:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVGPMbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 08:31:20 -0400
Received: from web32012.mail.mud.yahoo.com ([68.142.207.109]:21879 "HELO
	web32012.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261531AbVGPMbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 08:31:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jeWlSk/ZC4Om6J2CfyXI5cWeW3kdoLoxYtJEBhMgLQ4JheH+1OsganKUBb/LFTDdMJKOLEWejgk5OecDrdXc9g7lENU5fCpjx5Bl9igevw6YwN1p/rTvNsHYQ6tfhA6TMUuKSVRu8lr66faCX480ChhFS0skv1OvF2BrZVNbTjc=  ;
Message-ID: <20050716123114.99015.qmail@web32012.mail.mud.yahoo.com>
Date: Sat, 16 Jul 2005 05:31:14 -0700 (PDT)
From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050716111556.L19067@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> The interrupts are only claimed when the port is
> actually opened, so if
> only one port was open, you'll only see one
> appearing in /proc/interrupts.

Get it.

Thanks so much,

Sam


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
