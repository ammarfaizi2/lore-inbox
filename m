Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSJ3VJ3>; Wed, 30 Oct 2002 16:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJ3VJ3>; Wed, 30 Oct 2002 16:09:29 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:29732 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264934AbSJ3VJ2>;
	Wed, 30 Oct 2002 16:09:28 -0500
Message-ID: <3DC04C22.7060604@acm.org>
Date: Wed, 30 Oct 2002 15:16:18 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPMI driver for Linux, version 12
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been working a lot if different issues with different people, and I 
have a new version of the IPMI driver.  The location has moved, it's now 
on SourceForge at http://openipmi.sourceforge.net.

-Corey

PS - In case you don't know, IPMI is a standard for system management, 
it provides ways to detect the managed devices in the system and sensors 
attached to them.  You can get more information at 
http://www.intel.com/design/servers/ipmi/spec.htm.

