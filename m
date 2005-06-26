Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVFZXZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVFZXZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVFZXZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:25:46 -0400
Received: from kiln.isn.net ([198.167.161.1]:39312 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id S261639AbVFZXZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:25:42 -0400
Message-ID: <42BF3974.3080303@isn.net>
Date: Sun, 26 Jun 2005 18:25:40 -0500
From: "Garst R. Reese" <garstr@isn.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cc1: error: code model 'kernel' not supported in 32 bit mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I get trying to compile 2.6.12.1 for an AMD Sempron processor,
config Generic-x86-64
It's not likely a kernel problem other than keeping people from testing.
I did a make menuconfig from config-2.6.8.11-amd64-generic on debian 
Sarge 3.1
gcc version 3.3.5 (Debian 1:3.3.5-13)

pls cc me

Thanks,
   Garst


