Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268950AbUJPXDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268950AbUJPXDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 19:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUJPXDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 19:03:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8658 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268950AbUJPXDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 19:03:34 -0400
Subject: Re: Reconsider dropping "-final" EXTRAVERSION from 2.6.9 release
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ian E. Morgan" <imorgan@webcon.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410161316500.5062@dark.webcon.ca>
References: <Pine.LNX.4.61.0410161316500.5062@dark.webcon.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097964053.13224.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 16 Oct 2004 23:00:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-16 at 18:33, Ian E. Morgan wrote:
> Thankfully, 2.6.9-final is still in the testing tree. It is my hopes that it
> will actually be released as "2.6.9". That's always been good enough.

The -final tree doesn't seem to have anything to deal with O_DIRECT on
memory mapped video/af_packet/oss-audio files to start with, so it
doesn't look good enough to me, unless I missed a cunning fix elsewhere.

