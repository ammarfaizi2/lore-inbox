Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTFASmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFASmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:42:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:63370 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264039AbTFASmW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:42:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 1 Jun 2003 11:53:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Gutko <gutko@poczta.onet.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: What is wrong  with modules in 2.5.69-70 ?
In-Reply-To: <000501c3286e$62d1b510$17010101@hal>
Message-ID: <Pine.LNX.4.55.0306011151440.25548@bigblue.dev.mcafeelabs.com>
References: <000501c3286e$62d1b510$17010101@hal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Gutko wrote:

> What is wrong  with modules in 2.5.69-70 generally. Every option I compile
> as module does not work because modprobe says on boot "couldn't load module
> xxxxx". If I compile it in (*) then works ok. In 2.4.x modules works ok for
> me.
> I've updated all "boot" programs to versions mentioned in
> /Documentation/Changes
> Mandrake 9.1

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/module-init-tools-0.9.12.tar.gz



- Davide

