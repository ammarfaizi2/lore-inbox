Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVDVR12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVDVR12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 13:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVDVR12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 13:27:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:29161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262075AbVDVR1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 13:27:11 -0400
Date: Fri, 22 Apr 2005 10:29:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "K.R. Foley" <kr@cybsft.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix ultrastor.c compile error
In-Reply-To: <42690274.5040005@cybsft.com>
Message-ID: <Pine.LNX.4.58.0504221028050.2344@ppc970.osdl.org>
References: <42690274.5040005@cybsft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Apr 2005, K.R. Foley wrote:
>
> This simple patch fixes a compile error in the ultrastor driver. Patch 
> was originally submitted by Barry K. Nathan as referenced here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111391774018717&w=2
> I just regenerated it against your current git tree. Please apply.

Can you also verify that it works?

Finally, when forwarding other peoples patches, please make sure that you 
include their commentary, and their sign-off. In this case the original 
definitely has them..

		Linus
