Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVCCDEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVCCDEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVCCDBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:01:04 -0500
Received: from smtp819.mail.sc5.yahoo.com ([66.163.170.5]:8842 "HELO
	smtp819.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261431AbVCCDA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:00:29 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
Date: Wed, 2 Mar 2005 22:00:18 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0503021818580.12224-100000@hornet>
In-Reply-To: <Pine.GSO.4.44.0503021818580.12224-100000@hornet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503022200.18697.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 21:27, Joshua Hudson wrote:
> i8042: ACPI detection disabled
> i8042.c: Warning: Keylock active.

I really need dmesg when booting _without_ the option, i.e. non-working case.

Thanks!

-- 
Dmitry
