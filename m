Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSJWMTp>; Wed, 23 Oct 2002 08:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSJWMTo>; Wed, 23 Oct 2002 08:19:44 -0400
Received: from web40603.mail.yahoo.com ([66.218.78.140]:25769 "HELO
	web40603.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264872AbSJWMTo>; Wed, 23 Oct 2002 08:19:44 -0400
Message-ID: <20021023122549.57302.qmail@web40603.mail.yahoo.com>
Date: Wed, 23 Oct 2002 13:25:49 +0100 (BST)
From: =?iso-8859-1?q?Cathal=20Daly?= <cdaly24@yahoo.co.uk>
Subject: unresolved symbols problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Users,
      This problem is being a real pain in the neck
for me and I can't figure out any way to get around
it. I am trying to load an e1000 driver as a module
but I am getting unresolved symbols. The hash values
at the end of the exported symbols do not match the
corresponding hash values in the /proc/ksyms file in
the running kernel. I gather that this is because
module versioning is turned on in the kernel. I can't
compile the driver against the kernel as I don't have
the correct kernel sources. Is there any possible way
to get the network driver to load into this kernel
image without the kernel sources. I imagine the hash
values from /proc/ksyms and the driver unresolved
symbols will have to match but how can this be done. I
would really appreciate some help with this.

Thanks,
        Cathal


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
