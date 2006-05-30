Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWE3V5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWE3V5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbWE3V5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:57:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21936 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932514AbWE3V5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:57:38 -0400
Date: Tue, 30 May 2006 15:01:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Raphael Assenat <raph@raphnet.net>
Cc: alessandro.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add max6902 RTC support
Message-Id: <20060530150143.7e39dac3.akpm@osdl.org>
In-Reply-To: <20060530184949.GF797@aramis.lan.raphnet.net>
References: <20060530150913.GE797@aramis.lan.raphnet.net>
	<20060530203241.4a4de734@inspiron>
	<20060530184949.GF797@aramis.lan.raphnet.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 14:49:49 -0400
Raphael Assenat <raph@raphnet.net> wrote:

> + * Changelog:
> + * 
> + * 24-May-2006: Raphael Assenat <raph@8d.com>
> + *                - Major rework
> + *   				Converted to rtc_device and uses the SPI layer.
> + *
> + * ??-???-2005: Someone at Compulab
> + *                - Initial driver creation.

That's a problem.  According to the Developer's Certificate of Origin
process we'd need "Someone at Compulab" to send us a Signed-off-by:, along
with the assertions which that carries.

I mean, maybe you've finally found that code wot we stole from sco ;)
