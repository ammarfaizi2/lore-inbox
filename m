Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUDGUpy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUDGUpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:45:54 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:37086 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S264164AbUDGUpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:45:14 -0400
Date: Wed, 7 Apr 2004 22:45:03 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Uwe Lienig <Uwe.Lienig@fif.mw.htw-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ASUS A7V8X-X LAN/SOUND randomly freezes under linux-2.4.20
Message-ID: <20040407204503.GB10264@k3.hellgate.ch>
Mail-Followup-To: Uwe Lienig <Uwe.Lienig@fif.mw.htw-dresden.de>,
	linux-kernel@vger.kernel.org
References: <4058402A.6030407@fif.mw.htw-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4058402A.6030407@fif.mw.htw-dresden.de>
X-Operating-System: Linux 2.6.5 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004 13:10:18 +0100, Uwe Lienig wrote:
> [1.] One line summary of the problem:
> ASUS A7V8X-X LAN/SOUND at random freezes under linux-2.4.20 totally, no 
> response

How frequently does this happen? Does the problem still occur if you
remove support for APIC, ACPI, via-rhine? Have you tried the NMI
watchdog?

Roger
