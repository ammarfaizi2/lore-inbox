Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbTF3RlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTF3RlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 13:41:15 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36751
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265578AbTF3RlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 13:41:15 -0400
Subject: Re: PROBLEM: 2.4.21 ICH5 SATA related hang during boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Mock <jeff@mock.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
References: <5.1.0.14.2.20030629135412.03c1d940@mail.mock.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056995562.17567.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jun 2003 18:52:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-29 at 23:37, Jeff Mock wrote:
> I'm running a 2.4.21 kernel on a redhat 9.0 system.
> 
> I'm having a problem when using serial ATA drives on an Intel 875P/ICH5
> motherboard where the kernel will hang at approximately the same place
> in the boot process about 25% of the time.

Set the bios setting to legacy mode


