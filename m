Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSCVBJT>; Thu, 21 Mar 2002 20:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312597AbSCVBJJ>; Thu, 21 Mar 2002 20:09:09 -0500
Received: from topaz.3com.com ([192.156.136.158]:19601 "EHLO topaz.3com.com")
	by vger.kernel.org with ESMTP id <S312590AbSCVBIx>;
	Thu, 21 Mar 2002 20:08:53 -0500
Subject: what does update /etc/fstab do?
To: linux-kernel@vger.kernel.org
From: Hui_Ning@3com.com
Date: Thu, 21 Mar 2002 19:11:26 -0600
Message-ID: <OF4EBA2A25.5A24DF9A-ON86256B84.0005BFAF@3com.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am compiling 2.4.17UP version on my dual processor machine.  When I
reboot  with the new kernel, I just
can't pass the stage "update /etc/fstab". So I switch the reboot procedure
to interactive mode and bypass
update /etc/fstab stage.  Then I can boot the machine and log in and do
some work. Everything looks fine.
I have a few questions here:

1) What  does "update /etc/fstab" do?
2) What kind of harm will it cause if I skip this stage?
3) What can cause "update /etc.fstab" hang there?

Maybe all the questions are related. Thanks for any enlightenment.

hui

