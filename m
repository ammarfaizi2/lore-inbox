Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUH0NFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUH0NFX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 09:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUH0NFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 09:05:23 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:26116 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264919AbUH0NFR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 09:05:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Wouter Van Hemel <wouter-kernel@fort-knox.rave.org>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Date: Fri, 27 Aug 2004 16:04:35 +0300
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <33193.151.37.215.244.1093530681.squirrel@webmail.azzurra.org> <200408270917.47656.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.61.0408271445120.578@senta.theria.org>
In-Reply-To: <Pine.LNX.4.61.0408271445120.578@senta.theria.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408271604.35400.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 15:47, Wouter Van Hemel wrote:
> On Fri, 27 Aug 2004, Denis Vlasenko wrote:
> > Code is under GPL. You can add it back anyday. It's less work than
> > writing such a long email.
>
> I just happen to be better at writing rants than writing drivers. :)

You don't need to write anything. Just put *existing* driver back.
It's doable even if you never ever wrote 'hello world' C program.

> If the maintainer wants it pulled, I feel it would be stealing to add it
> back into the kernel without his approval. Perhaps we could rewrite the
> driver and merge it with some other webcam driver projects.

This is the problem. It is far easier to _feel_ something
than to _do_ something.
-- 
vda
