Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTJDQiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTJDQiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:38:23 -0400
Received: from mail1-106.ewetel.de ([212.6.122.106]:49595 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S262608AbTJDQiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:38:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: permissions inside linux-2.6.0-test6.tar.bz2
In-Reply-To: <CXsk.7ta.11@gated-at.bofh.it>
References: <CXsk.7ta.13@gated-at.bofh.it> <CXsk.7ta.11@gated-at.bofh.it>
Date: Sat, 4 Oct 2003 18:38:21 +0200
Message-Id: <E1A5pQD-0005rp-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Oct 2003 18:30:16 +0200, you wrote in linux.kernel:

> Just don't unpack the sources as the user wanting to do the
> compile, then tar can't set file ownership and the permissions are
> okay for compiling.

s/don't//

-- 
Ciao,
Pascal
