Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270481AbRHIRy5>; Thu, 9 Aug 2001 13:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270484AbRHIRyr>; Thu, 9 Aug 2001 13:54:47 -0400
Received: from imladris.infradead.org ([194.205.184.45]:63500 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S270481AbRHIRyb>;
	Thu, 9 Aug 2001 13:54:31 -0400
Date: Thu, 9 Aug 2001 18:54:39 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Ivan Kalvatchev <iive@yahoo.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts on tmpfs and swapfs
In-Reply-To: <20010809104623.98344.qmail@web13601.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0108091853010.22374-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan.

 >> I have to admit that tmpfs is new to me, but I would assume it's
 >> a filing system for temporary files, that works along the lines
 >> of a ramdisk?

 > Don't let the name fool you. This filesystem is used for share
 > memory and is extension to shmfs (that should be obsolete in
 > 2.6.x kernels). It is temporaly becouse it loses all it's
 > content on reboot/umount.

Ah - so not what I assumed at all. That completely changes the
scenario. Thanks for clarifying that.

Best wishes from Riley.

