Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUIPFQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUIPFQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUIPFQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:16:15 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:51898 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267469AbUIPFQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:16:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Jeremiah Holt <jholt5638@gmail.com>
Subject: Re: Patch gamecon.c
Date: Thu, 16 Sep 2004 00:16:01 -0500
User-Agent: KMail/1.6.2
References: <c49d2fb004091515492737d6a3@mail.gmail.com>
In-Reply-To: <c49d2fb004091515492737d6a3@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409160016.01973.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 September 2004 05:49 pm, Jeremiah Holt wrote:
> This patch changes gc_psx_delay from 60 usecs to 10 usecs. At 60usecs
> my system was almost unusable anything a app wanted to use the the
> joystick I tried the gc_psx_delay= switch for the module but that
> appears to be no longer supported. Please personally CC: all comments
> to me thanks

It is simply 'psx_delay=xxx' if compiled as a module and gamecon.psx_delay=
if gamecon is built in.
 
-- 
Dmitry
