Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTHSUoo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbTHSUm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:42:28 -0400
Received: from binky.tuxfriends.net ([212.105.197.44]:38670 "EHLO
	binky.tuxfriends.net") by vger.kernel.org with ESMTP
	id S261428AbTHSUeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:34:21 -0400
Message-ID: <3F428A4F.4050600@zaplinski.de>
Date: Tue, 19 Aug 2003 22:36:31 +0200
From: Olaf Zaplinski <olaf@zaplinski.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: de, en
MIME-Version: 1.0
To: jeff millar <wa1hco@adelphia.net>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.0-test3 does not mount root fs
References: <3F3F6E38.9070002@zaplinski.de> <20030817141651.A20799@electric-eye.fr.zoreil.com> <006f01c364d0$b40641f0$6401a8c0@wa1hco> <3F407B41.10303@zaplinski.de> <002101c365d7$a0ce8950$6401a8c0@wa1hco>
In-Reply-To: <002101c365d7$a0ce8950$6401a8c0@wa1hco>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-KAVCheck: binky.tuxfriends.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeff millar wrote:
> Ok...interesting...sounds like yet another variation on the problem.
> Herbert Potzl is interested in debugging this and sent me two patches to
> gather more debugging info.  I'll forward them to you

Yup, these patches worked, 2.6.0-test3 is running.

Olaf

