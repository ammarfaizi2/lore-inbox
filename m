Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbULBADE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbULBADE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULBACo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:02:44 -0500
Received: from a.mail.sonic.net ([64.142.16.245]:43650 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S261511AbULBABI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:01:08 -0500
Newsgroups: local.ml.linux.kernel
From: dalgoda@ix.netcom.com (Mike Castle)
Subject: Re: linux-2.4.28 compile problem with gcc-3.4.3
References: <20041201221051.GR790@thune.sonic.net> <20041201224623.GA5148@stusta.de>
Organization: House of Linux
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Path: not-for-mail
Originator: nexus@thune.mrc.org (Mike Castle)
Date: Wed, 01 Dec 2004 16:01:05 -0800
Message-ID: <1j2282xnoc.ln2@thune.mrc-home.org>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041201224623.GA5148@stusta.de>,
Adrian Bunk  <bunk@stusta.de> wrote:
>This is a known bug already fixed in 2.4.29-pre1.

Grrr.

I'm an idiot:

Mikael Pettersson:
  o gcc34 fastcall mismatch fixes for rwsem-spinlock

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
