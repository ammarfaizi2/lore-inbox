Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbUATTd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265754AbUATTd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:33:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:64474 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265753AbUATTdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:33:25 -0500
Subject: Re: Can't boot 2.6.1-mm4 or -mm5
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200401202145.06005.arvidjaar@mail.ru>
References: <200401202145.06005.arvidjaar@mail.ru>
Content-Type: text/plain
Message-Id: <1074627172.6832.95.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 20 Jan 2004 14:32:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-20 at 13:52, Andrey Borzenkov wrote:
> I can't boot either of them. 2.6.1-mm3 was OK; compiling and booting -mm4 or 
> -mm5 with the same config as before (since 2.5.69 actually). Compiling and 
> booting with VESA framebuffer and vga=788 gives empty screen; booting with 
> vga=normal or compiling without framebuffer support goes as far as
> 
> Uncompressing kernel ... booting
<snip>

I've had this before if the wrong CPU type was selected, I know it
soudns like a newbie question, but are you sure you have the right one? 

AFAIR This kinda thing happend on a PII compile with march=pentium3
-- 
Omkhar

