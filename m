Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTL2OLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 09:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTL2OLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 09:11:38 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:64650 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263310AbTL2OLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 09:11:37 -0500
Message-ID: <3FF033AF.2080905@myrealbox.com>
Date: Mon, 29 Dec 2003 06:01:19 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PS2 mouse changes for 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get good results from last night's PS2 mouse patches.  My one
problem machine now works perfectly again without the psmouse_noext
parameter I've been using for several months.

Two observations:

I see no deprecation warnings when starting the kernel with
psmouse_noext, which I was expecting to see.

The mouse is announced as a 'generic wheel mouse', but it is
really a Kensington Orbit trackball.  Unfortunately I don't
have a wheel mouse to test with, so I can't comment there.

Thanks for the fixes!
