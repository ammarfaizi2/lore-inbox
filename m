Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUK3Lcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUK3Lcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 06:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUK3Lcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 06:32:53 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:35261 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262041AbUK3Lcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 06:32:48 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Yet another filesystem - sffs
Date: Tue, 30 Nov 2004 11:32:47 +0000 (UTC)
Organization: Cistron Group
Message-ID: <cohlov$s7p$1@news.cistron.nl>
References: <41AC2DBE.1080501@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1101814367 28921 62.216.29.200 (30 Nov 2004 11:32:47 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41AC2DBE.1080501@ntlworld.com>,
Bernard Hatt  <bernard.hatt@ntlworld.com> wrote:
>I had an idea for a filesystem as an alternative to using a raw disk
>partition for storing a single (large) data file (eg. a DVD image or a
>database data file), adding the convenience of a file length, permissions
>and a uid/gid.
>
>As I now have some functional code (a 'compile outside the kernel'
>module, only tested against i386/2.6.9) I thought I'd share the sffs
>(single file file-system) code for comments/testing.

I've been using such a filesystem for years, since Linux 2.0 ..
It's at ftp://ftp.cistron.nl/pub/people/miquels/kernel/v2.[0246]/rawfs-*

I use it with the CNFS (Cyclic News File System) storage option
of INN for high-performance usenet news transit systems.

Mike.

