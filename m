Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUE2ON0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUE2ON0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 10:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUE2ONZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 10:13:25 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:17879 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264917AbUE2ONY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 10:13:24 -0400
Date: Sat, 29 May 2004 16:12:47 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler version
Message-ID: <20040529161247.A19214@electric-eye.fr.zoreil.com>
References: <20040529111616.A16627@electric-eye.fr.zoreil.com> <20040529115238.A17267@electric-eye.fr.zoreil.com> <200405291330.i4TDUhsN000547@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405291330.i4TDUhsN000547@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Sat, May 29, 2004 at 02:30:43PM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> :
[...]
> In my opinion, code that doesn't compile with 2.95.3 is broken - 2.95.3 is

If you are asking for technical details, please read the thread ending
at: http://oss.sgi.com/projects/netdev/archive/2004-05/msg00440.html

[...]
> Basically, 2.95.3 is something of a point of reference, so it only makes
> sense to throw it out once we have a new point of reference.

It makes no sense to religiously recommended 2.95.3 if it is known broken.

If nobody comes with a better approach, I'll simply submit a patch to
remove the 2.95.3 recommendation (+ #error for the driver as suggested by ak).

--
Ueimor
