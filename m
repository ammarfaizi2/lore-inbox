Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSCIHS7>; Sat, 9 Mar 2002 02:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292520AbSCIHRj>; Sat, 9 Mar 2002 02:17:39 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292522AbSCIHPZ>;
	Sat, 9 Mar 2002 02:15:25 -0500
Date: Fri, 08 Mar 2002 22:02:05 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: PnP BIOS driver status
In-Reply-To: <3C897238.CA903C93@didntduck.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-id: <1015642925.940.55.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.2
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <1015628440.14518.212.camel@thanatos>
 <3C895E90.696E92A2@didntduck.org> <1015636233.988.9.camel@thanatos>
 <3C897238.CA903C93@didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-08 at 21:23, Brian Gerst wrote:
> How does this patch look?  Against 2.5.6

Better than mine.

Alan: I suggest applying Brian's patch plus the 
change from 'kpnpbios' to 'kpnpbiosd'.

I'll integrate Brian's patch into my patch for David
Jones's patch to 2.5.x ... tomorrow.

