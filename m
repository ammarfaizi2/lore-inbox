Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbUCOSSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUCOSSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:18:35 -0500
Received: from relay-6m.club-internet.fr ([194.158.104.45]:63718 "EHLO
	relay-6m.club-internet.fr") by vger.kernel.org with ESMTP
	id S262655AbUCOSSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:18:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fabien R <the_edge123@club-internet.fr>
To: linux-kernel@vger.kernel.org
Subject: Kernel/libc function validation
Date: Mon, 15 Mar 2004 19:18:33 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20040315181832.C62D125619@relay-6m.club-internet.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is what I want to do.

I have to test all the functions used by a Linux binary, up to the libc 
function calls.

Thus, I have to provide evidences that the libc (or kernel) function called 
has been tested.

1) I want to know if you are using an automated procedure to test and 
validate a new kernel version.

2) Do you use test suites like osdl.org or ltp.sourceforge.net ?

3) If not, is it easy to test manually a libc function.

Thanks in advance,

Fabien

Note: Could you use "reply all" to answer because I've only subscribed to the 
 kernel-digest list ?
