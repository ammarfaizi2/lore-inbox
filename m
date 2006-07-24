Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWGXQ3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWGXQ3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWGXQ3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:29:50 -0400
Received: from lucidpixels.com ([66.45.37.187]:27349 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751394AbWGXQ3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:29:49 -0400
Date: Mon, 24 Jul 2006 12:29:48 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
Subject: 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
Message-ID: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beginning at 2.6.17 to 2.6.17.6, there is a serious XFS bug that results 
in filesystem corruption, there was a 1 line bugfix patch that was 
released recently and I was wondering when 2.6.17.7 would be released with 
that patch?  It affected ALL my Linux machines (x86) running XFS and many 
people on the XFS mailing list who upgraded to 2.6.17.  I understand when 
there is a root exploit or DoS bug, the kernel is naturally patched by the 
-stable team and a new version is released immediately.  Does filesystem 
corruption not constitute an immediate new -stable release of the kernel?


