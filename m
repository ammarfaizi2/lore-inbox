Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUHCObS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUHCObS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUHCObS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:31:18 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:26439 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264697AbUHCObP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:31:15 -0400
Message-ID: <757c55c6040803073153dcddf5@mail.gmail.com>
Date: Tue, 3 Aug 2004 11:31:11 -0300
From: Maikon Bueno <maikon@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sending a byte to keyboard buffer
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,   
I'm writing a driver for a mouse.   
When a button is pressed, the driver must send a char to the keyboard buffer. 
So, mouse buttons must behave like keyboard keys.
I would like to know how to send a char to the keyboard buffer. Is it need to
use the outb() function?
Does anybody know how to do that?
Thanks!

Maikon.
