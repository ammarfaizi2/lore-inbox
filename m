Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbUKZVZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbUKZVZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbUKZVY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:24:56 -0500
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:9910 "EHLO
	pbl.ca") by vger.kernel.org with ESMTP id S264020AbUKZUHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:07:48 -0500
Message-ID: <41A78D0A.5060308@pbl.ca>
Date: Fri, 26 Nov 2004 14:07:38 -0600
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: network console
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anybody attempted to implement console on network interface (with or 
without encryption, preferably with some form of authentication)? 
Either using TCP, UDP, Ethernet datagrams, or whatever.  Possibly with 
LILO support so that LILO prompt can be accessed through it too (OK, 
LILO support is probably *way* too much to ask for, but maybe some other 
more complex boot loader?).

I know the security implications of using such an console, but for my 
home environment, if something like that existed it would be quite 
handy.  I have a box with no keyboard/monitor, and to use serial console 
I'd have to route loooooong serial cable through half of my house, and I 
already have network cable in place (took me half of the day to route 
that one, and another half of the day to wash myself from all the dirt 
and dust hidden in most obscure places that light of the day never touches).

If such a beast exists, what would be required on the client side? 
Linux-only client, or is there Windows client too?

TIA,
Alex
