Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUCaVLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUCaVLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:11:54 -0500
Received: from citi.umich.edu ([141.211.133.111]:61091 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S262473AbUCaVLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:11:53 -0500
Date: Wed, 31 Mar 2004 16:11:52 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: timer question
Message-ID: <Pine.BSO.4.33.0403311609180.17377-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all-

i'm looking for a way to do microsecond resolution timing in the RPC
client.  i need a timer or timestamp function that is fairly cheap, that i
can call on any hardware platform, and that i can invoke from inside a
bottom half.

any suggestions?

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

