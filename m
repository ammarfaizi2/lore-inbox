Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUCIL5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUCIL5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:57:07 -0500
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:42638 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261887AbUCIL5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:57:05 -0500
Date: Tue, 9 Mar 2004 13:56:28 +0200
From: Palko Jukka <jpalko@kolumbus.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.6.x + kvm switches
Message-ID: <20040309115628.GA27360@jpalko.dyndns.org>
Reply-To: jpalko@kolumbus.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Operating-System: Linux jpalko 2.4.24-1-k7
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings

As a curiosity question I would like to ask whether the 2.6.x kernel
series will sometime in the nearby future start functioning better with
KVM switches?

Currently I get it to work with my KVM by adding psmouse.proto=bare to
the grub kernel entry, but this leaves me without the fourth button in
the mouse. I need to use at least psmouse.proto=exps or no entry entry
for psmouse.proto to get the fourth button operational in my mouse.

But anything better than psmouse.proto=bare as the setting and my mouse
will definately go haywire when switching between machines... :(

-- 
     Jukka Palko        jpalko@iki.fi
                        jpalko@kolumbus.fi
