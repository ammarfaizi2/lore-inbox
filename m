Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJUPEP>; Mon, 21 Oct 2002 11:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbSJUPEP>; Mon, 21 Oct 2002 11:04:15 -0400
Received: from 62-190-200-233.pdu.pipex.net ([62.190.200.233]:57355 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261581AbSJUPEO>; Mon, 21 Oct 2002 11:04:14 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210211519.g9LFJiLt004996@darkstar.example.net>
Subject: Re: gzip compression of vmlinux
To: amolk@ishoni.com (Amol Kumar Lad)
Date: Mon, 21 Oct 2002 16:19:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1035243705.2202.3.camel@amol.in.ishoni.com> from "Amol Kumar Lad" at Oct 21, 2002 07:41:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Currently we use gzip to compress vmlinux ( and finally form bzImage).
> I am planning to replace it with bzip2 . Should I go ahead with it ?
> Will it find its place in the latest kernel ? 
> We save some 35k of compressed bzImage using bzip2

There was a discussion about using bzip2 on this list a few months
ago:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.1/0467.html

John.
