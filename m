Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSJBRXm>; Wed, 2 Oct 2002 13:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJBRXg>; Wed, 2 Oct 2002 13:23:36 -0400
Received: from gaea.projecticarus.com ([195.10.228.71]:45463 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S261297AbSJBRXb>; Wed, 2 Oct 2002 13:23:31 -0400
Message-ID: <3D9B3AE1.2000902@walrond.org>
Date: Wed, 02 Oct 2002 19:28:49 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serverworks IDE driver broken in 2.5.40
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the driver built-in, the drives are not recognised. Built as a 
module, it crashes on loading.

However I can see everything fine with the generic IDE driver

Works fine in 2.4.19+

