Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVDAMn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVDAMn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 07:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVDAMn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 07:43:27 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:12994 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S262724AbVDAMnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:43:24 -0500
Subject: [RFC] : remove unreliable, unused and unmainained arch from kernel.
In-Reply-To: 
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 16:11:33 +0400
Message-Id: <1112357493492@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Fri, 01 Apr 2005 16:43:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, developers.

In order to compete with the new upcoming releases of the
various OSes, and to join all developers efforts into the 
one really promising and powerfull direction,
I present you following patch, 
which removes absolutely unused in a real world, 
unsupported by vendors and definitely hard to build
from commodity hardware arch.
Due to it's famous bugability there are tons of quirks 
all over the place in the Kernel tree, so it is only 
begining. 
Let's create our OS the best all over the world - let's remove i386.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

