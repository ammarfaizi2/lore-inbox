Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTH2VcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTH2VcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:32:25 -0400
Received: from codepoet.org ([166.70.99.138]:11406 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264491AbTH2Vbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:31:51 -0400
Date: Fri, 29 Aug 2003 15:31:36 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-ac1
Message-ID: <20030829213136.GC3150@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Bas Mevissen <ml@basmevissen.nl>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308291258.h7TCwmU24496@devserv.devel.redhat.com> <3F4F5401.1070401@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4F5401.1070401@basmevissen.nl>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 29, 2003 at 03:24:17PM +0200, Bas Mevissen wrote:
> How do you feel about adding things like Alsa

I made a patch adding alsa to 2.4.x a while back...  You just
need to apply these three patches.  

    http://codepoet.org/kernel/080-proc_dir_entry.bz2
    http://codepoet.org/kernel/081-export-rtc.bz2
    http://codepoet.org/kernel/082_alsa-0.9.2.bz2

I've not updated it since 2.4.22-rc2, but it should patch into
2.4.22 without any problem...  It works for me anyways.  

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
