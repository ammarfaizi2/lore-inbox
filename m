Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbUJ1GPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbUJ1GPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbUJ1GNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:13:35 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18956 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262828AbUJ1GLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:11:41 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Lei Yang <lya755@ece.northwestern.edu>
Subject: Re: set blksize of block device
Date: Thu, 28 Oct 2004 09:11:15 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>
References: <417FE6A8.5090803@ece.northwestern.edu> <41804F04.4000300@ece.northwestern.edu> <418058A8.5080706@ece.northwestern.edu>
In-Reply-To: <418058A8.5080706@ece.northwestern.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410280911.15756.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 05:25, Lei Yang wrote:
> Or in other words, is there generic routines for block devices such that 
> we could:
> 
> get (set) block size of a block device;
> read an existing block (e.g. block 4);
> write an existing block (e.g. block 5);

Can you stick to "reply below quote" style please?

> > If nobody could answer this question, what about another one? Is there 
> > a system call or a kernel interface that would allow me to write a 

Can you use read, write and seek system calls?
--
vda

