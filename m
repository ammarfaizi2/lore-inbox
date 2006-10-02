Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWJBAT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWJBAT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWJBAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 20:19:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932515AbWJBAT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 20:19:26 -0400
Date: Sun, 1 Oct 2006 17:19:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Message-Id: <20061001171912.b7aac1d8.akpm@osdl.org>
In-Reply-To: <20060930190810.30b8737f.alessandro.guido@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 19:08:10 +0200
Alessandro Guido <alessandro.guido@gmail.com> wrote:

> Make the sony_acpi use the backlight subsystem to adjust brightness value
> instead of using the /proc/sony/brightness file.
> (Other settings will still have a /proc/sony/... entry)

umm, OK, but now how do I adjust my screen brightness? ;)

I assume that cute userspace applications for controlling backlight
brightness via the generic backlight driver either exist or are in
progress?  What is the status of that?

Thanks.
