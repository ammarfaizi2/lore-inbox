Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUCVSDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbUCVSDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 13:03:55 -0500
Received: from zeus.polsl.gliwice.pl ([157.158.1.3]:43269 "EHLO
	zeus.polsl.gliwice.pl") by vger.kernel.org with ESMTP
	id S261712AbUCVSDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 13:03:55 -0500
Message-ID: <405F2A74.9010508@polsl.gliwice.pl>
Date: Mon, 22 Mar 2004 19:03:32 +0100
From: Albeiro <albeiro@polsl.gliwice.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; PL; rv:1.6) Gecko/20040113
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.6.4)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I personally use it for a long time now and I really like it.
> Same here, I hope this functionality gets merged sooner rather then later.
yes, i think, that vanilla kernel realy miss such an thing. personaly i don't even would call it extension,
because it's just missing part of the kernel, which should be here from the begining of `bind` option. now behaving
of mount one_dir into_another -o bind,ro is a least missleading, because it just _silently_ ignores the read-only option mounting read write.
nobody would even assume, that it is mounted read write. bind mounting should just work like any other.

Albeiro

