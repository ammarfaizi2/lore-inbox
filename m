Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVAYSem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVAYSem (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVAYSel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:34:41 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:13263 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261484AbVAYSek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:34:40 -0500
Message-ID: <41F6916F.7060000@blue-labs.org>
Date: Tue, 25 Jan 2005 13:35:27 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041229
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11-rc2
References: <200501232251.42394.david-b@pacbell.net>
In-Reply-To: <200501232251.42394.david-b@pacbell.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PMTU bug -- or better said, bad firewall admin who blocks all ICMP.

http://blue-labs.org/clue/mtu-mss.php

-david

David Brownell wrote:

>I'm seeing a problem with TCP as accessed through KMail (SuSE 9.2, x86_64).
>But oddly enough, only for sending mail, not reading it; and not through
>other (reading) applications... it's a regression with respect to rc1 and
>earlier kernels.  Basically, it can only send REALLY TINY emails...
>
>  
>
