Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJMSqj>; Sun, 13 Oct 2002 14:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJMSqj>; Sun, 13 Oct 2002 14:46:39 -0400
Received: from m-net.arbornet.org ([209.142.209.161]:47887 "EHLO arbornet.org")
	by vger.kernel.org with ESMTP id <S261582AbSJMSqh>;
	Sun, 13 Oct 2002 14:46:37 -0400
Date: Sun, 13 Oct 2002 14:54:01 -0400 (EDT)
From: Eric Blade <eblade@m-net.arbornet.org>
Message-Id: <200210131854.g9DIs1I0062874@m-net.arbornet.org>
To: linux-kernel@vger.kernel.org
Subject: Evolution and 2.5.x
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
 
  I'm guessing that not too many of the kernel developers use Evolution as
their email program :)   Since I started picking up the 2.5.x series, at around
2.5.34, Evolution does not run anywhere near properly.  I'm not sure if that
is a kernel issue, or a problem with Evolution's code..  But it did improve
quite a bit with all the low-level process management that was in the 2.5.3x 
series.  It still doesn't work right though.  (in 2.5.34, evolution would
just plain halt the system ... in 2.5.42, it mostly works right, as long
as you don't try to compose a message.. composing a message will leave you
with a whole buch of zombie processes). 
 
