Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTI1EPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 00:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTI1EPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 00:15:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21001 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262323AbTI1EPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 00:15:41 -0400
Date: Sun, 28 Sep 2003 00:14:35 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       Brian Gerst <bgerst@didntduck.org>
Subject: Re: [2.6 patch] select ZLIB_{IN,DE}FLATE
In-Reply-To: <20030927100551.GJ2881@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0309280014110.17382-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, Adrian Bunk wrote:

> Hi Linus,
> 
> similar to the patch Brian Gerst sent for CRC32, this patch changes
> ZLIB_{IN,DE}FLATE to be select'ed.
> 

Good idea.


- James
-- 
James Morris
<jmorris@redhat.com>


