Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264601AbUDVRfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbUDVRfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbUDVRfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:35:09 -0400
Received: from stogtw01.enlight.net ([212.209.183.10]:21025 "EHLO
	stodns01.enlightnet.local") by vger.kernel.org with ESMTP
	id S264601AbUDVRfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:35:05 -0400
Date: Thu, 22 Apr 2004 19:34:58 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Kyle Davenport <kdd@tvmax.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.25 crashes windows
In-Reply-To: <4070E72D.7090702@tvmax.net>
Message-ID: <Pine.LNX.4.44.0404221933160.32465-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Apr 2004 17:35:01.0552 (UTC) FILETIME=[23E04B00:01C42890]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2004, Kyle Davenport wrote:

> >2.4.25 allows you to enable the cifs unix extensions in smbfs. Perhaps
> >turning those off makes a difference?
> >
> >The other change is that smbfs in 2.4.25 has large file support. smbfs in 
> >2.4.24 should behave like 2.4.22.
> >
> ok, I'll try that tomorrow. Any idea what those directives are?

You can turn off the "UE" in the config (make menuconfig or whatever).
I'm sure you figured that out already.

Did it make any difference?

/Urban

