Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269710AbUISC2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269710AbUISC2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 22:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUISC2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 22:28:24 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:42100 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269710AbUISC2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 22:28:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech and Microsoft Tilt Wheel Mice. Driver suggestions wanted.
Date: Sat, 18 Sep 2004 21:28:18 -0500
User-Agent: KMail/1.6.2
Cc: mike cox <mikecoxlinux@yahoo.com>
References: <20040919015125.32796.qmail@web52803.mail.yahoo.com>
In-Reply-To: <20040919015125.32796.qmail@web52803.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409182128.19138.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 08:51 pm, mike cox wrote:
> I'm modifying Vojtech Pavlik's 2.6.8.1 kernel
> mousedev.c mouse driver to support the new "Tilt
> wheel" functionality on the Logitech MX1000 Laser
> Mouse, and the Microsoft Wireless Optical mouse with
> Tilt Wheel Technology.

How will the tilt information be exported? And what is wrong with using
event interface? I think that the evdev patches are included into X shipped
by Gentoo, Mandrake and Fedora at least...

-- 
Dmitry
