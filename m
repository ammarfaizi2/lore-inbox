Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285473AbRLGT1j>; Fri, 7 Dec 2001 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285474AbRLGT13>; Fri, 7 Dec 2001 14:27:29 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:37127 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285473AbRLGT1V>; Fri, 7 Dec 2001 14:27:21 -0500
Message-ID: <3C111815.60312F84@linux-m68k.org>
Date: Fri, 07 Dec 2001 20:27:17 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] /
In-Reply-To: <1007740060.2031.2.camel@thanatos>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thomas Hood wrote:

> As Richard has pointed out, devfs is still marked
> "experimental", so it's not unreasonable to make changes
> if they are improvements.

Sure, he can, but that's no excuse if other drivers depend on a certain
behaviuor.

bye, Roman
