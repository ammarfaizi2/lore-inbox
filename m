Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbUL2XwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUL2XwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 18:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUL2XwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 18:52:14 -0500
Received: from smtp1.iitb.ac.in ([203.199.51.149]:51661 "HELO smtp1.iitb.ac.in")
	by vger.kernel.org with SMTP id S261447AbUL2XwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 18:52:11 -0500
Message-ID: <33539.10.107.23.131.1104364329.squirrel@www.it.iitb.ac.in>
Date: Thu, 30 Dec 2004 05:22:09 +0530 (IST)
Subject: doubt
From: durgam@it.iitb.ac.in
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 i  am accessing a variable from two modules . in one module iam  reading
the varible , and in another module i am updating the variable for each a
second.
in the second module i am using interruptible_sleep_on_timeout so that it
will
be wake up after one second and update the varible. but the problem i am
facing is i couldn't read the variable in the first module  for the moment
of time when the second module gets sleep. please can any one help me to
come out .

phani
