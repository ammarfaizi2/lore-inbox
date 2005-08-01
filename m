Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263233AbVHAKJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbVHAKJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 06:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVHAKDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 06:03:52 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:17107 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S262498AbVHAKBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 06:01:24 -0400
Date: Mon, 1 Aug 2005 12:01:24 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
Message-ID: <20050801100124.GB21132@janus>
References: <20050729162006.GA18866@janus> <20050729170319.23f24a01.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729170319.23f24a01.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 05:03:19PM -0700, Andrew Morton wrote:
> 
> (The IDR problem is fixed in Linus's current tree)

yep, enabled PM and running rc4-git3, everything seems normal now.

-- 
Frank
