Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTKXRvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTKXRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:51:15 -0500
Received: from lvs00-fl-n05.valueweb.net ([216.219.253.151]:42641 "EHLO
	ams005.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S263808AbTKXRvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:51:13 -0500
Message-ID: <3FC244C7.4030002@coyotegulch.com>
Date: Mon, 24 Nov 2003 12:49:59 -0500
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0 and Checkpointing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently run across CHPOX, Checkpointing for Linux 
(http://www.cluster.kiev.ua/tasks/chpx_eng.html). I was wondering if 
anyone else could illuminate me further about using this module with 
2.6.0? I'll probably try this myself later today, after I get test10 
running.

Has any condieration been made for integrating checkpointing directly 
into the main kernel build? I'm thinking 2.7, not 2.6, of course.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing
In development: Alex, a database for common folk

