Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUJ3SUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUJ3SUr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUJ3STt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:19:49 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:46739 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261295AbUJ3SRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:17:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with hotplug functions
Date: Sat, 30 Oct 2004 13:16:58 -0500
User-Agent: KMail/1.6.2
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <1099153682.16247.30.camel@pegasus>
In-Reply-To: <1099153682.16247.30.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410301316.58908.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 11:28 am, Marcel Holtmann wrote:
> Hi,
> 
> I have a little problem with the hotplug functions and in particular
> with the one from firmware_class. The problem is that the extra env
> variables are not set when hotplug is called.

Hm, that must be the reason why firmare loading for my atmel wireless
card stopped working recently.

-- 
Dmitry
