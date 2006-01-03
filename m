Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWACGmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWACGmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 01:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWACGmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 01:42:38 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:7332 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751171AbWACGmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 01:42:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH 1/1] usb/input: Add missing keys to hid-debug.h
Date: Tue, 3 Jan 2006 01:42:31 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <20060102233730.GA29826@hansmi.ch>
In-Reply-To: <20060102233730.GA29826@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601030142.32623.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 January 2006 18:37, Michael Hanselmann wrote:
> This patch adds the missing keys from input.h to hid-debug.h.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>

Thank you Michael, I will add it to my tree. I still ponder your other
patch and whether we should employ something like hooks for HID.

-- 
Dmitry
