Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWA0QI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWA0QI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWA0QI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:08:59 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:36007 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751496AbWA0QI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:08:58 -0500
Subject: Re: netboot broken ?
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43D9C8C5.3020902@t-online.de>
References: <43D9C8C5.3020902@t-online.de>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 08:08:58 -0800
Message-Id: <1138378138.4801.9.camel@obsidian>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-27 at 08:16 +0100, Knut Petersen wrote:

> Any ideas? Can anybody please
>  - confirm that network booting does still work
>  - confirm that it is broken.

Network booting has been in limbo for years, and hasn't had a lick of
maintenance in approximately forever.  The way forward is supposed to be
via initramfs, but nobody is testing the nfsroot code in there, so it
has a fair probability of not working.

	<b

