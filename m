Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbTECVeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTECVeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:34:04 -0400
Received: from newman.cs.purdue.edu ([128.10.2.6]:54450 "EHLO
	newman.cs.purdue.edu") by vger.kernel.org with ESMTP
	id S263429AbTECVeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:34:03 -0400
Date: Sat, 3 May 2003 16:46:29 -0500
From: Jae-Young Kim <jaykim@cs.purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: maximum size of wmem_max / rmem_max
Message-ID: <20030503214629.GA7398@punch.cs.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi, I am curious about the maximum value of wmem_max and rmem_max.
As far as I know the values of them are maximum byte size of send buffer
and receive buffer allocated for a socket.

What I'm wondering is how much memory we can assign for them.
Can we assign the whole memory space for them? Or is there any limitation
of the values?

- Jay

