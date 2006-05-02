Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWEBTvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWEBTvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWEBTvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:51:15 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:17534 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751230AbWEBTvO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:51:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JJzX+l25QezRVz8WFDGMtbH95gilmJ02MpUhWwtwsrLDT6ydnktv3MpGKOZWYrDsZR6DxwctRAXohIoh2xGIqLQrX+raIrfxKwBvdUBoh054EpJKCpCMrN9p2uN83TR7OYXgwlbp7XDbk9Zd0h9EbxfP8D6HosLwMKh9WMI2iMA=
Message-ID: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com>
Date: Tue, 2 May 2006 21:51:13 +0200
From: "Olivier Fourdan" <fourdan@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: framebuffer broken in 2.6.16.x and 2.6.17-rc3 ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

Sorry if this has been already covered recently, but it seems that the
framebuffer doesn't work anymore in 2.6.16.9 and 2.6.17-rc3, while it
worked in 2.6.16 at least.

I'm surprised noone has raised that issue yet, so I'm wondering if I'm
missing something obvious :) When using the fb in 2.6.16.x and
2.6.17-rc3, the screen stays just black, nothing is displayed... I'm
using the regular unaccelerated vesa framebuffer.

I'm wondering if this could related to the fb changes that occured
after 2.6.16 initial release and if other people are experiencing
issues with frame buffer recently.

Cheers,
Olivier.
