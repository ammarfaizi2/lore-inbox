Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWA2EO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWA2EO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 23:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWA2EO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 23:14:29 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:8845 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750815AbWA2EO2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 23:14:28 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: [PATCH] iforce: fix -ENOMEM check
Date: Sat, 28 Jan 2006 23:14:20 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601281903.28176.marek.vasut@gmail.com>
In-Reply-To: <200601281903.28176.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601282314.21222.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 13:03, Marek Vašut wrote:
> I have tried that patch, but nothing changed ...
> That error is still there and no new device in /dev/input appears

You do have updated udev, don't you? Could you pease post your dmesg
with the patch applied?

-- 
Dmitry
