Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbVKDXEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbVKDXEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKDXEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:04:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750884AbVKDXEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:04:44 -0500
Date: Fri, 4 Nov 2005 15:04:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: [PATCH 0/3] swsusp: simplifications and cleanups
Message-Id: <20051104150458.04ad3439.akpm@osdl.org>
In-Reply-To: <200511020000.11183.rjw@sisk.pl>
References: <200511020000.11183.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> The following series of patches implements some simplifications
> and cleanups of swsusp.

Sorry, they clash significantly with other swsusp patches I have here. 
Could you please redo these against next -mm?

(Am currently recovering from a few days out-of-town and have a ~300 patch
backlog.  Am trying (and struggling) to get -mm1 out by Sunday.  I suck).
