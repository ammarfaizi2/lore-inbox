Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTLWU6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTLWU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:58:23 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:51846 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S261928AbTLWU6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:58:22 -0500
To: ryutaroh@it.ss.titech.ac.jp
cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
References: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp>
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 23 Dec 2003 12:58:20 -0800
In-Reply-To: <fa.kfih9j0.q4e8bi@ifi.uio.no> (ryutaroh@it.ss.titech.ac.jp's
 message of "Fri, 19 Dec 2003 12:26:46 GMT")
Message-ID: <7v4qvrtfo3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "rm" == ryutaroh  <ryutaroh@it.ss.titech.ac.jp> writes:

rm> We cannot input | (bar) with the JP 106 keyboards (the standard Japanese
rm> keyboards).

Known problem.  Look for string "Japanese" in the post-halloween doc.

http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt

