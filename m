Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUGLRC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUGLRC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUGLRC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:02:27 -0400
Received: from core.ece.northwestern.edu ([129.105.5.1]:17359 "EHLO
	core.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S266888AbUGLRC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:02:26 -0400
Message-ID: <1089651469.40f2c30d44364@core.ece.northwestern.edu>
Date: Mon, 12 Jul 2004 11:57:49 -0500
From: lya755@ece.northwestern.edu
To: linux-kernel@vger.kernel.org
Subject: question about ramdisk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 138.15.107.179
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am learning linux kernel and have a question about ramdisk. When loading an 
executable in ramdisk, is the kernel loading the code all at a time to memory 
and then execute, or is it loading only a page at one time and generating a 
page fault to fetch another page?

Thanks for any comments! Waiting desprately for your help.

Lei


_________________________________________________________
This message was sent through the NU ECE webmail gateway.
