Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbTLRPbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbTLRPbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:31:25 -0500
Received: from pop.gmx.de ([213.165.64.20]:29058 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265212AbTLRPbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:31:17 -0500
X-Authenticated: #2294038
Message-ID: <3FE1C843.70608@gmx.net>
Date: Thu, 18 Dec 2003 16:31:15 +0100
From: Christian Schmidt <GMSmith@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031112
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Bug-Report, Linux 2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When starting up the new Kernel 2.6.0 in vesa-fb mode, german umlauts 
(and possibly other special characters) aren't displayed properly. 
Problem has been there since test9 or even earlier versions.

When trying to access a RIO 500 mp3-player through the tools from 
rio500.sf.net, the rio freezes and needs to be unplugged and the battery 
needs to be removed to make it revert to its normal state. It's not 
possible to up- or download files on or from it. Problem has been there 
since test9 or even earlier aswell.

Regards, Christian Schmidt

