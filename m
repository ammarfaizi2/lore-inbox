Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVCVOEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCVOEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 09:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVCVOEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 09:04:33 -0500
Received: from [81.2.110.250] ([81.2.110.250]:21212 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261254AbVCVOEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 09:04:24 -0500
Subject: Re: [PATCH 1/4] Lifebook: dmi on x86 only
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200503220214.55379.dtor_core@ameritech.net>
References: <20050217194217.GA2458@ucw.cz>
	 <1111419068.8079.15.camel@localhost>
	 <200503220213.46375.dtor_core@ameritech.net>
	 <200503220214.55379.dtor_core@ameritech.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111500109.14833.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 22 Mar 2005 14:01:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-22 at 07:14, Dmitry Torokhov wrote:
> ===================================================================
> 
> Input: lifebook - DMI facility is only available on i386, do not
>        attempt to compile on anything else.

DMI is also available on x86-64, and its present although not in Linux
on
iA64

