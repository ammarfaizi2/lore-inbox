Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUDWBsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUDWBsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 21:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264347AbUDWBsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 21:48:15 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:48216 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264263AbUDWBsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 21:48:15 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Graphics Mode Woes
Date: Thu, 22 Apr 2004 20:48:12 -0500
User-Agent: KMail/1.6.1
Cc: "Bobby Hitt" <Bob.Hitt@bscnet.com>
References: <01b801c428cb$737005d0$0900a8c0@bobhitt>
In-Reply-To: <01b801c428cb$737005d0$0900a8c0@bobhitt>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404222048.12839.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 07:39 pm, Bobby Hitt wrote:

> CONFIG_FB_VGA16=y
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> CONFIG_FB_RIVA=y
^^^^^^^^^^^^^^^^^^^^

If you want vesa framebuffer why even select rivabf (NVidia)?

-- 
Dmitry
