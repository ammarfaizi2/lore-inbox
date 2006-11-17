Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756015AbWKQWx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbWKQWx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756016AbWKQWx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:53:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:19942 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756015AbWKQWx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:53:58 -0500
Date: Fri, 17 Nov 2006 14:53:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org,
       rasmus@msconsult.dk (Rasmus =?ISO-8859-1?Q?B=F8g?= Hansen)
Subject: Re: smbfs (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
Message-Id: <20061117145342.f566a62a.akpm@osdl.org>
In-Reply-To: <slrnelofru.7lr.olecom@flower.upol.cz>
References: <867ixyvum6.fsf@gere.msconsult.dk>
	<slrnelofru.7lr.olecom@flower.upol.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 10:30:41 +0000 (UTC)
Oleg Verych <olecom@flower.upol.cz> wrote:

> [ Adding e-mail of Andrew Morton, he may have clue about who to ping ;]
> [ MAINTAINERS.smbfs seems to be emply                                 ]

smbfs is unmaintained and we'd like to kill it off.  Please use cifs.
