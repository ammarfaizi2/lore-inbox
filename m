Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbUDTNAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbUDTNAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUDTNAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 09:00:20 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:42608 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262920AbUDTM7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:59:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse fixes for 2.6.5
Date: Tue, 20 Apr 2004 07:59:11 -0500
User-Agent: KMail/1.6.1
Cc: Kim Holviala <kim@holviala.com>, vojtech@suse.cz
References: <200404201038.46644.kim@holviala.com>
In-Reply-To: <200404201038.46644.kim@holviala.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404200759.11446.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 02:38 am, Kim Holviala wrote:
> Some fixes for PS/2 mice:
> 
> - fixed hotplugging (real reset of device instead of softreset)
> - support for Targus Scroller mice (from my last weeks patch)
> - extended protocol probing fixed
 
Why do you have Tragus as a config option - just set the protocol mask
correctly by default...

-- 
Dmitry
