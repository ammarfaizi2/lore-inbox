Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUEPQrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUEPQrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 12:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbUEPQra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 12:47:30 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:56709 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263679AbUEPQr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 12:47:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.6-mm2] no keyboard on AMD
Date: Sun, 16 May 2004 11:47:24 -0500
User-Agent: KMail/1.6.2
Cc: FabF <Fabian.Frederick@skynet.be>, Andrew Morton <akpm@osdl.org>
References: <1084533319.8303.6.camel@bluerhyme.real3>
In-Reply-To: <1084533319.8303.6.camel@bluerhyme.real3>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161147.26447.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 May 2004 06:15 am, FabF wrote:
> Andrew,
> 
> 	Here's my i8042 output with debug activated against 2.6.6-mm2 with
> i8042 debug patch applied (result : no keyboard available).
>

I would try -mm3 as it has that troublesome i8042 interrupt handling patch
reversed.

-- 
Dmitry
