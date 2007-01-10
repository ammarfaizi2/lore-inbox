Return-Path: <linux-kernel-owner+w=401wt.eu-S965011AbXAJSHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbXAJSHg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbXAJSHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:07:36 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:45780 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbXAJSHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:07:34 -0500
Message-ID: <45A52B64.7070904@s5r6.in-berlin.de>
Date: Wed, 10 Jan 2007 19:07:32 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Lei W <leiw.again@yahoo.com.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: Jumping into Kernel development: About -rc kernels...
References: <20070110150051.63974.qmail@web15914.mail.cnb.yahoo.com>
In-Reply-To: <20070110150051.63974.qmail@web15914.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/2007 4:00 PM, Lei W wrote:
> If now i have applied patch-2.6.19.1,how can i goto
> 2.6.20-rc4 ?

$ cd linux/
$ patch -p1 -R < patch-2.6.19.1
$ patch -p1 < patch-2.6.20-rc4
-- 
Stefan Richter
-=====-=-=== ---= -=-=-
http://arcgraph.de/sr/
