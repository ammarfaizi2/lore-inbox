Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTJWAy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 20:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbTJWAy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 20:54:26 -0400
Received: from cabm.rutgers.edu ([192.76.178.143]:13071 "EHLO
	lemur.cabm.rutgers.edu") by vger.kernel.org with ESMTP
	id S261473AbTJWAyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 20:54:25 -0400
Date: Wed, 22 Oct 2003 20:54:25 -0400 (EDT)
From: Ananda Bhattacharya <anandab@cabm.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: Tyan S2466 and 3ware Lockup
Message-ID: <Pine.LNX.4.44.0310222046321.4347-100000@puma.cabm.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have read Vincent Touquet  about the Tyan motherboard and 
the 3ware problems that cause a lockup. He believes that 
this is due to dma causing the PCI bus to overload and then 
the system crashes. I am running a similar system with 
a National Semiconducotrs GigaBit Card and then there is a 
3-ware card with 12 disks on it. I believe to fix this 
problem is to use dma=off as a boot option. Does anyone have 
another idea, or an exact idea why lockups like this happen?
I have not as of yet used the dma=off option myself. 
thank you 
-Anand 


-- 
Eventually the revolutionaries become the established culture, and then what will they do.

- Linus Torvalds, In Politics/Anarchy

