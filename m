Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWBRRma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWBRRma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWBRRma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:42:30 -0500
Received: from web32603.mail.mud.yahoo.com ([68.142.207.230]:52084 "HELO
	web32603.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932101AbWBRRma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:42:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1HEOzt5BdmxNCCJWpFBG/KcnI63hVQy3HPNxypnEAz9AysrCD9Mng/pCuMu+m1FUOo3cikb4tYs736TbfJWGsL3GtEiQS4Qdd7hSKgm0/Dx3WOE0hPKkXvX7jXBz/FzEQkX3h8lobsxNJC6LXPnKl7y1Ps7k+tf93CQORJhR7C0=  ;
Message-ID: <20060218174229.76852.qmail@web32603.mail.mud.yahoo.com>
Date: Sat, 18 Feb 2006 09:42:29 -0800 (PST)
From: Irfan Habib <irfanhab@yahoo.com>
Subject: How to find the CPU usage of a process
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a research student, working on self-organizing
grids. 
I wanted to ask how can I find the cpu usage of a
process, as opposed to runtime, with cpu usage I mean
actually how many time slices were awarded to a
specific process, like the runtime of job may be 4 s,
but this also includes time it was suspended by some
interrupt, or had to wait for the scheduler etc..

What is the easiest way to do that? is their any
userlevel tool for it?
Thanks in advance

Irfan Habib

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
