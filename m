Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTLOW3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTLOW3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:29:25 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:9624 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264110AbTLOW3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:29:24 -0500
From: "Eric Sandeen" <sandeen@sgi.com>
Subject: Re: 2.4.24-pre1 hangs with XFS on LVM filesystem full
Date: Mon, 15 Dec 2003 16:29:22 -0600
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Message-Id: <pan.2003.12.15.22.29.21.879085@sgi.com>
References: <fa.nj5bn9m.1khkr82@ifi.uio.no> <fa.lsavf2q.25afr8@ifi.uio.no>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 21:02:21 +0000, Emilio Gargiulo wrote:

> It is reproduceable on LVM and on simple partition like /dev/hda10.

Ah, if you can reproduce it on a simple partition, then I'd better
give it a whirl here.  If you think it has something to do with
the size of the fs vs. memory, can you post those details
for your tests?  I.e. how much memory, and how big is the fs where
you saw the failure?

Thanks,
-Eric

