Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTH3KHw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTH3KHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:07:52 -0400
Received: from tmi.comex.ru ([217.10.33.92]:9629 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263487AbTH3KHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:07:51 -0400
X-Comment-To: Ed Sweetman
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Sat, 30 Aug 2003 14:13:19 +0400
In-Reply-To: <3F4F923F.9070207@wmich.edu> (Ed Sweetman's message of "Fri, 29
 Aug 2003 13:49:51 -0400")
Message-ID: <m3oey7o3ls.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Ed Sweetman (ES) writes:


 ES> I'm using the largest inode size possible for ext3 for the filesystem
 ES> tested.

inode size doesn't make sense because extents use i_data space only


