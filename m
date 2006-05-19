Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWESG2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWESG2h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 02:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWESG2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 02:28:37 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31107 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932241AbWESG2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 02:28:36 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: FIXED: [WARNING] Please be careful when using "git add" from "next" branch
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
	<7v64k3698l.fsf@assigned-by-dhcp.cox.net>
	<7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
	<7vsln74sv7.fsf_-_@assigned-by-dhcp.cox.net>
Date: Thu, 18 May 2006 23:28:34 -0700
In-Reply-To: <7vsln74sv7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 18 May 2006 01:52:44 -0700")
Message-ID: <7vy7wyil4d.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> There is still a small breakage in the built-in "git add" on the
> "next" branch that ends up creating nonsense tree objects.

This was fixed this morning, in case I scared people.
 

