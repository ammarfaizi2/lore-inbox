Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUEBM4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUEBM4l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 08:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUEBM4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 08:56:41 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:14414 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263024AbUEBM4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 08:56:40 -0400
Message-ID: <4094F005.5000501@poggs.co.uk>
Date: Sun, 02 May 2004 13:56:37 +0100
From: Peter Hicks <peter.hicks@poggs.co.uk>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.6) Gecko/20040413 Debian/1.5-3 StumbleUpon/1.89
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.6-rc3, nvidia.o and CONFIG_4KSTACKS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Just a quickie - the NVidia driver kills my machine when running 2.6.6-rc3 
with CONFIG_4KSTACKS turned on.

My fault for choosing the card.  Any chance of a warning in the help text for 
that option?


Peter.
