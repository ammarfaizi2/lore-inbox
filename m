Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbUAET2W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUAET2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:28:22 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:7296 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S265158AbUAET2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:28:21 -0500
Message-ID: <3FF9BAD3.9040804@speakeasy.net>
Date: Mon, 05 Jan 2004 11:28:19 -0800
From: John Gardiner Myers <jgmyers@speakeasy.net>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch/revised] wake_up_info() ...
References: <fa.kf16nao.126qarq@ifi.uio.no>
In-Reply-To: <fa.kf16nao.126qarq@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would seem better if info were a void *, to permit sending more than 
a single unsigned long.


