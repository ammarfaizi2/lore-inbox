Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVCDNfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVCDNfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbVCDNfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:35:54 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:51624 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262891AbVCDNe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:34:28 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: swsusp: allow resume from initramfs
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@nurfuerspam.de
Date: Fri, 04 Mar 2005 14:36:26 +0100
References: <fa.e8vvlml.hjolb5@ifi.uio.no> <fa.h2h05q4.mmkqpm@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1D7Cyh-0001Vg-PG@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Would it not be simpler to just add "resume=03:02" to the boot command line?

Some devices have random device numbers.

