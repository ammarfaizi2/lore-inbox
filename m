Return-Path: <linux-kernel-owner+w=401wt.eu-S1754709AbXAAVik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbXAAVik (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 16:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbXAAVik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 16:38:40 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:3876 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754709AbXAAVij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 16:38:39 -0500
Date: Mon, 1 Jan 2007 22:39:13 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>,
       "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-Id: <20070101223913.7b1fddbf.khali@linux-fr.org>
In-Reply-To: <20061222104056.GB7009@in.ibm.com>
References: <20061220141808.e4b8c0ea.khali@linux-fr.org>
	<m1tzzqpt04.fsf@ebiederm.dsl.xmission.com>
	<20061220214340.f6b037b1.khali@linux-fr.org>
	<m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com>
	<20061221101240.f7e8f107.khali@linux-fr.org>
	<20061221145922.16ee8dd7.khali@linux-fr.org>
	<1166723157.29546.281560884@webmail.messagingengine.com>
	<20061221204408.GA7009@in.ibm.com>
	<20061222090806.3ae56579.khali@linux-fr.org>
	<20061222104056.GB7009@in.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Sorry for the delay, I'm just back from vacation. I tried it all again
with 2.6.20-rc3 just in case, but the problem I've hit is still present.

On Fri, 22 Dec 2006 16:10:56 +0530, Vivek Goyal wrote:
> Can you please also upload boot/compressed/vmlinux.

I've shared the whole build tree so that you can peek at files without
waiting for me to upload them. It is temporarily available at:
  http://jdelvare.pck.nerim.net/linux/relocatable-bug/
Hidden files are there too, just not listed.

Thanks,
-- 
Jean Delvare
