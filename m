Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUDTNU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUDTNU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 09:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUDTNU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 09:20:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57028 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263001AbUDTNU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 09:20:57 -0400
Date: Tue, 20 Apr 2004 09:20:38 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: "David S. Miller" <davem@redhat.com>
cc: Clay Haapala <chaapala@cisco.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto/crc32c implementation, updated 040419
In-Reply-To: <20040419163622.7834f23a.davem@redhat.com>
Message-ID: <Xine.LNX.4.44.0404200920290.14155-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004, David S. Miller wrote:

> On Mon, 19 Apr 2004 16:31:55 -0500
> Clay Haapala <chaapala@cisco.com> wrote:
> 
> > This patch agains 2.6.6-rc1-bk implements the CRC32C algorithm as a
> > type of digest.  It is implemented as a wrapper for libcrc32c,
> > available in a separate patch.  The crypto CRC32C module will be
> > used by the iscsi-sfnet driver.
> 
> James, you got these two bits?
> 

Yep, they look ok to me.


- James
-- 
James Morris
<jmorris@redhat.com>


