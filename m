Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUHXQzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUHXQzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268133AbUHXQzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:55:48 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:19983 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S268127AbUHXQzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:55:36 -0400
Date: Tue, 24 Aug 2004 18:56:14 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: [BK PATCH] PCI and I2C fixes for 2.6.8
Message-Id: <20040824185614.2309da83.khali@linux-fr.org>
In-Reply-To: <20040823183323.GA1236@kroah.com>
References: <20040823183323.GA1236@kroah.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> Here are some PCI and I2C patches for 2.6.8.  The trees are merged
> together because they were conflicting with each other in the pci
> quirks area.  They include lots of different fixes and changes, and a
> few new i2c drivers.  All of these patches have been in the last few
> -mm releases.

Everything from my own list is in there :)

Thanks for the excellent work.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
