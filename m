Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUGLTXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUGLTXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUGLTXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:23:53 -0400
Received: from mail.njit.edu ([128.235.251.32]:44523 "EHLO mail-gw4.njit.edu")
	by vger.kernel.org with ESMTP id S261474AbUGLTXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:23:52 -0400
Date: Mon, 12 Jul 2004 15:23:50 -0400 (EDT)
From: rahul b jain cs student <rbj2@oak.njit.edu>
To: linux-kernel@vger.kernel.org
Subject: printk functionality
Message-ID: <Pine.GSO.4.58.0407121516320.8220@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I want to add functionality to the printk function such that I can read
values off sk_buff and print them to a file specified by me rather than
the kernel defined files. So what I want to do is add a new option
like KERN_INFO.

Does anyone know of a documentation or has ideas on how I can go about
doing this ?

Thanks,
Rahul.
