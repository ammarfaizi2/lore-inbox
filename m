Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVBCLeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVBCLeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVBCLdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:33:39 -0500
Received: from main.gmane.org ([80.91.229.2]:8084 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262981AbVBCLar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:30:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Date: Thu, 3 Feb 2005 12:18:00 +0100
Message-ID: <MPG.1c6baa8589a717e798970d@news.gmane.org>
References: <20050123190109.3d082021@localhost.localdomain> <200501312240.35776.dtor_core@ameritech.net> <20050131210635.3c582934@localhost.localdomain> <200502010014.29326.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp-116-150.29-151.libero.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> No I don't but by the looks of it (constant stream of bad data) it looks
> like somehow the touhcpad was reset back into PS/2 compatibility mode.
> resetafter would catch it and reinitialize touchpad restoring proper
> protocol.

My Dell Inspiron 8200 shows very sluggish keyboad AND Touchpad 
responsiveness *under Windows* after plugging (and subsequently 
unplugging) an external PS/2 device (mouse OR keyboard) (I have 
never tried this under Linux though), so it might be a hardware 
issue.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

