Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261997AbSJIURp>; Wed, 9 Oct 2002 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSJIURo>; Wed, 9 Oct 2002 16:17:44 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:63840 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261997AbSJIURo>;
	Wed, 9 Oct 2002 16:17:44 -0400
Message-ID: <3DA4904F.7000801@acm.org>
Date: Wed, 09 Oct 2002 15:23:43 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IPMI driver for Linux, version 5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have put a new version of the IPMI driver on my home page 
(http://home.attbi.com/~minyard) that removes the Linus-incompatable 
typedefs.  The only typedefs left are "handle" ones.

-Corey

PS - In case you don't know, IPMI is a standard for system management, 
it provides ways to detect the managed devices in the system and sensors 
attached to them.  You can get more information at 
http://www.intel.com/design/servers/ipmi/spec.htm

