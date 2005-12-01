Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVLATwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVLATwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVLATwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:52:13 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:50186 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S932424AbVLATwN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:52:13 -0500
Date: Thu, 1 Dec 2005 20:51:45 +0100
From: jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: mouse resync messages since 2.6.15-rc2-mm1, still in 2.6.15-rc3-mm1
Message-ID: <20051201195145.GA20896@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I access my workstations with a KVM switch, a Rose Vista model, and
since 2.6.15-rc2-mm1, I get an awful lot of

logips2pp: Detected unknown logitech mouse model 1
psmouse.c: resync failed, issuing reconnect request

messages. What is the information content in these messages? I take it
they tell me something important - but I can't understand what. If they
are just noise, could they please be removed?
I know my mouse works when I switch consoles; this KVM has worked for
ages with linux. 

I can always #if 0 them out myself, but I'm curious what the meaning of
these messages is.

Thanks,
Jurriaan
-- 
Fire control was manual now. So was the coffeemaker, but with green
smoke gathering under the ceiling, that didn't seem as crucial somehow.
        Tanya Huff - The Better Part of Valor
Debian (Unstable) GNU/Linux 2.6.15-rc2-mm1 5404 bogomips load 1.76
