Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWB1BNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWB1BNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWB1BNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:13:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751876AbWB1BNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:13:41 -0500
Date: Mon, 27 Feb 2006 17:12:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: Linux v2.6.16-rc5
Message-Id: <20060227171237.38ad41d9.akpm@osdl.org>
In-Reply-To: <4403A1CD.6030203@keyaccess.nl>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<4403586C.2020004@keyaccess.nl>
	<20060227145120.0712eaac.akpm@osdl.org>
	<44038BFE.6090907@keyaccess.nl>
	<4403A1CD.6030203@keyaccess.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
>
> On 2.6.16-rc without Adam's fix, both the 
>  "pnp: match found with" and the "foo_pnp_remove" lines are missing:

Useful, thanks.  Hopefully we'll hear from Adam in the next day or two
(he's intermittent lately).  If not, I guess we'll need to jam the patch in
anwyay.

In which case we might as well jam it in now, so we get more testing.
