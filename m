Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTLWSwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTLWSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:51:33 -0500
Received: from imo-d02.mx.aol.com ([205.188.157.34]:43169 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S262344AbTLWStm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:49:42 -0500
Date: Tue, 23 Dec 2003 13:49:39 -0500
From: jpo234@netscape.net
To: linux-kernel@vger.kernel.org
Subject: Re: SCO's infringing files list
MIME-Version: 1.0
Message-ID: <48AA13B1.4085457E.00065BAA@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 62.96.207.14
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

 > It's almost certainly the "libc-2.2.2.tar.Z" file that we want - that's 
 > the one that is going to contain the sys_errlist[] lists etc. Note how 
 > this libc-2.2.2 announcement predates the merging of the kernel header by 
 > almost a month - the kernel header information came from libc, not the 
 > other way around.

On ibiblio.org is http://www.ibiblio.org/pub/historic-linux/ftp-archives/sunsite.unc.edu/Nov-06-1994/GCC/libc-4.5.26.tar.gz

This one contains
libc-linux/sysdeps/linux/_errlist.c dated from 04/14/1993. Unfortunately
it does not contain a copyright notice. 

Files from glibc in this package come with a FSF Copyright Notice, 
so its probably not from glibc. Does somebody recognize this file?

Regards
  Joerg

__________________________________________________________________
New! Unlimited Access from the Netscape Internet Service.
Beta test the new Netscape Internet Service for only $1.00 per month until 3/1/04.
Sign up today at http://isp.netscape.com/register
Act now to get a personalized email address!

Netscape. Just the Net You Need.
