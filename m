Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbSI2Vpo>; Sun, 29 Sep 2002 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261825AbSI2Vpo>; Sun, 29 Sep 2002 17:45:44 -0400
Received: from gaea.projecticarus.com ([195.10.228.71]:6036 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S261822AbSI2Vpo>; Sun, 29 Sep 2002 17:45:44 -0400
Message-ID: <3D9775BF.3090504@walrond.org>
Date: Sun, 29 Sep 2002 22:50:55 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE Problems with 2.5.39
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't boot with 2.5.39 because the built-in  ide driver (ServerWorks 
CSB5) can't see hda, and VFS says "Cannot open root device "hda3" or 
03:03" which results in a kernel panic

Works fine with 2.4.20-pre? with identical kernel setup and kernel 
parameter root=/dev/hda3

Is this a known problem? Any way around it or patches?

TIA
Andrew

