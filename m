Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272122AbTG2VBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272128AbTG2VBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:01:42 -0400
Received: from diomedes.noc.ntua.gr ([147.102.222.220]:93 "EHLO
	diomedes.noc.ntua.gr") by vger.kernel.org with ESMTP
	id S272122AbTG2VBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:01:35 -0400
Message-ID: <3F26E221.6060306@gmx.net>
Date: Wed, 30 Jul 2003 00:07:45 +0300
From: Dimitris Apostolou <jimis@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related) -- conclusion
References: <3F26CAF2.8070009@gmx.net> <200307291958.h6TJw43o030219@turing-police.cc.vt.edu>
In-Reply-To: <200307291958.h6TJw43o030219@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> So you want to use a number that controls the CPU scheduling to force the network
> scheduling to go along?  That's a bad idea waiting to happen.
> 

Read my initial posting, what I propose is defining priorities for net and disk
I/O independant to CPU priority



