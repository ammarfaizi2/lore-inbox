Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSHRSiu>; Sun, 18 Aug 2002 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSHRSiu>; Sun, 18 Aug 2002 14:38:50 -0400
Received: from codepoet.org ([166.70.99.138]:45036 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315721AbSHRSiu>;
	Sun, 18 Aug 2002 14:38:50 -0400
Date: Sun, 18 Aug 2002 12:42:52 -0600
From: Erik Andersen <andersen@codepoet.org>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre3 boot hang
Message-ID: <20020818184251.GA23266@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux mailing-list <linux-kernel@vger.kernel.org>
References: <20020818153145.GA3184@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020818153145.GA3184@df1tlpc.local.here>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 18, 2002 at 05:31:45PM +0200, Klaus Dittrich wrote:
> SMP, P-III, Intel-BX
> 
> booting Linux 2.4.20-pre3 stops after 
> 
> Linux NET4.0 for Linux 2.4 
> Based upon Swansea University Computer Society NET3.039 
> Initializing RT netlink socket 

On my UP Athlon, booting 2.4.20-pre3 hangs right after 
the "apm: BIOS version" message...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
