Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265166AbUELSb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265166AbUELSb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbUELSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:31:57 -0400
Received: from ns.suse.de ([195.135.220.2]:52656 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265162AbUELSbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:31:52 -0400
Subject: Re: [PATCH] [2.6] Make reiserfs not to crash on oom
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <20040512165038.GA72981@linuxhacker.ru>
References: <20040512165038.GA72981@linuxhacker.ru>
Content-Type: text/plain
Message-Id: <1084386693.2583.241.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 14:31:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 12:50, Oleg Drokin wrote:
> Hello!
> 
>   Thanks to Standford guys, a case where reiserfs can dereference NULL pointer
>   if memory allocation fail during mount was identified.
> 
>   Here's 2.6 version of patch.

Thanks Oleg, this looks right.

-chris


