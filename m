Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTLOWsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLOWsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:48:14 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:38334 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264113AbTLOWsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:48:10 -0500
From: "Eric Sandeen" <sandeen@sgi.com>
Subject: Re: 2.4.24-pre1 hangs with XFS on LVM filesystem full
Date: Mon, 15 Dec 2003 16:47:44 -0600
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Message-Id: <pan.2003.12.15.22.47.44.724355@sgi.com>
References: <fa.nj5bn9m.1khkr82@ifi.uio.no> <fa.lsavf2q.25afr8@ifi.uio.no>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, a quick test with a kernel from Dec 7, on a 128M box
and an 8.5G XFS filesystem on a "normal" scsi device did not hang
for me.

-Eric

