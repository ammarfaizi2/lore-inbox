Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbTKZXFt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTKZXFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:05:49 -0500
Received: from [212.35.254.18] ([212.35.254.18]:22466 "EHLO mail2.midnet.co.uk")
	by vger.kernel.org with ESMTP id S264365AbTKZXFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:05:48 -0500
Date: Wed, 26 Nov 2003 23:05:50 +0000
From: Tim Kelsey <tk@midnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Help building module for 2.6.0
Message-Id: <20031126230550.37785544.tk@midnet.co.uk>
Organization: Midland Internet
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok im trying to build a kernel module (my first :) ) when i build it on a 2.4 box everything is fine when i build it on my laptop running 2.6.0-t10 it builds fine but when i try and insmod it i get 

sh$ insmod ./hgn.o 
insmod: error inserting './hgn.o': -1 Invalid module format

I have attached my Makefile. Please could some one tell me if this is due to the way i compile the module (my guess) or if it is likly caused by my code. Any pointers would be welcome.

Thnx for any help
Tim Kelsey


p.s. I know this is kind of like walking into a filharmonic auchestra with a waveing a tin drum :P so if there is a more apropriate place to post this kind of question pls let me know.
