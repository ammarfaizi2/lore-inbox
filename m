Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUATXYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUATXYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:24:31 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:10142 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S265885AbUATXYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:24:30 -0500
Date: Wed, 21 Jan 2004 00:09:07 +0100
From: GCS <gcs@lsc.hu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5
Message-ID: <20040120230907.GA20425@lsc.hu>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 05:56:42PM -0500, Thomas Molina <tmolina@cablespeed.com> wrote:
> Finding module dependencies:  cat: 
> /sys//devices/pci0000:00/0000:00:07.2/usb1/bNumConfigurations: No such 
> file or directory
> /etc/hotplug/usb.agent: line 144: [: too many arguments
 I think you use Debian, and it's a bug in their scripts, not in the
kernel itself.
/GCS
