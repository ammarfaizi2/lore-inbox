Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264564AbTLMNEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 08:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264599AbTLMNEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 08:04:08 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:22958 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264564AbTLMNEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 08:04:06 -0500
Date: Sat, 13 Dec 2003 14:01:06 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Marcus Blomenkamp <Marcus.Blomenkamp@epost.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: r8169 GigE driver problem, locks up 2.4.23 NFS subsystem
Message-ID: <20031213140106.A24017@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200312131300.05847.Marcus.Blomenkamp@epost.de>; from
Marcus.Blomenkamp@epost.de on Sat, Dec 13, 2003 at 01:00:05PM +0100
[nfs+r8169 foobar]
> If anyone is interested, i have dmesg output and ethereal log files handy.

Yes.

A few questions:
- the client behaves correctly with a 8139, be it with 2.4.23-pre9 or
  2.6.0-test11 ?
- could you be more specific wrt "special realtek supplied version" ?

--
Ueimor
