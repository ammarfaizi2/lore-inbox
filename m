Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTJEMjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbTJEMjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:39:31 -0400
Received: from intra.cyclades.com ([64.186.161.6]:7392 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263094AbTJEMja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:39:30 -0400
Date: Sun, 5 Oct 2003 09:42:30 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org, <davem@redhat.com>
Subject: iproute2 not compiling anymore
Message-ID: <Pine.LNX.4.44.0310050940160.27815-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Erik, 

In previous messages you said iproute used to compile on "olders" 2.4.x 
kernel but doesnt compile anymore on recent 2.4. Is that information 
correct ? 

Can you tell me in more detail what is failing?

Interfaces should not change in a stable kernel. 

