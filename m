Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbSLaWFc>; Tue, 31 Dec 2002 17:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSLaWFc>; Tue, 31 Dec 2002 17:05:32 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:58376 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S264749AbSLaWFb>; Tue, 31 Dec 2002 17:05:31 -0500
Date: Tue, 31 Dec 2002 14:13:58 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: linux-kernel@vger.kernel.org
Subject: Usermode NFS - still in existence ?
Message-ID: <20021231141201.D88624-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a system running a vendor supplied kernel that I do not have the
ability to change.  Further, it is modified enough that normal modules
will not load into it - and of course I cannot compile modules to work
with it since I don't have the source to the kernel.

And for some reason they did not compile NFS in.

And I need this system to be an NFS _client_.

What are my options ?  I see that at some point there was a usermode NFS
... does this still exist ? Is there some other way of mounting an NFS
volume from userland - really any solution is fine, I just need to mount
my nfs volume from this server.

thanks!

