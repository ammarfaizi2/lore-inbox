Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268277AbTBYTdX>; Tue, 25 Feb 2003 14:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268281AbTBYTdX>; Tue, 25 Feb 2003 14:33:23 -0500
Received: from fmr01.intel.com ([192.55.52.18]:36303 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268277AbTBYTdW>;
	Tue, 25 Feb 2003 14:33:22 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A8471380CA@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: daveman@bellatlantic.net, Jerry Cooperstein <coop@axian.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Thinkpad Keyboard nuttiness since 2.5.60 with power managemen
	t
Date: Tue, 25 Feb 2003 11:43:26 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: daveman@bellatlantic.net [mailto:daveman@bellatlantic.net] 
> I am seeing a strange keyboard related issue as well on a 
> Thinkpad A20M. It seems if I walk away for say, 20 minutes, 
> come back and try to input a password to KDE's screen saver, 
> the FIRST keystroke I make is not recognized at all. All 
> keystrokes after the first one register perfectly fine. This 
> is on the laptop's built-in keyboard. I too am using ACPI. If 
> I don't wait long enough it doesn't happen, so I do believe 
> it has something to do with power management. I first noticed 
> it in 2.5.61(first 2.5 kernel that would boot for me) and am 
> currently running 2.5.63, where I still see it. I am not 
> using modules.
> 
> If anyone would like more info on this, please let me know.

I am seeing the same behavior under Windows on an IBM T20. This makes me
think it is not something the kernel is to blame for.

Regards -- Andy
