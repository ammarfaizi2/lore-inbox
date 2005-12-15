Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbVLOAsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbVLOAsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 19:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbVLOAsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 19:48:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32648 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965107AbVLOAsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 19:48:36 -0500
Date: Wed, 14 Dec 2005 16:50:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Reed <mdr@sgi.com>
Cc: James.Bottomley@SteelEye.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [GIT PATCH] final SCSI fixes for 2.6.15-rc5
Message-Id: <20051214165003.29e0904c.akpm@osdl.org>
In-Reply-To: <43A0B6CA.9090200@sgi.com>
References: <1134604909.11150.2.camel@mulgrave>
	<43A0B6CA.9090200@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reed <mdr@sgi.com> wrote:
>
> If possible, a comment on my previous email which identified two
> other issues with SCSI would be appreciated before 2.6.15 goes
> final.

Just so nobody else has to go hunting, here:

	http://marc.theaimsgroup.com/?l=linux-scsi&m=113458339109319&w=2
