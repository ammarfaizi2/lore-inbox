Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTL2Rxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTL2Rxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:53:44 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:22741 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263893AbTL2Rxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:53:43 -0500
Message-ID: <3FF06A26.8060609@wmich.edu>
Date: Mon, 29 Dec 2003 12:53:42 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Walt H <waltabbyh@comcast.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net> <3FEFDE4A.1030208@wmich.edu> <3FF0580C.5070604@comcast.net>
In-Reply-To: <3FF0580C.5070604@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check out test11-mm1's cdrom.c.  I think it'll make things clear.  I 
just replaced the cdrom.c and ide-cd.h and ide-cd.c files in 2.6.0-mm1 
with 2.6.0-test11-mm1's and things are working perfect.


