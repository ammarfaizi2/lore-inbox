Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbTIXQdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIXQdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:33:42 -0400
Received: from lvs00-fl-n06.valueweb.net ([216.219.253.152]:34988 "EHLO
	ams006.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S261480AbTIXQdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:33:41 -0400
Message-ID: <3F71C712.9070503@coyotegulch.com>
Date: Wed, 24 Sep 2003 12:32:18 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Minimizing the Kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to created the smallest, fastest kernel that supports all the 
necessary features of a given system.

Obviously, the answer is very system dependent, requiring a keen 
knowledge of the relationships between hardware and Linux components.

Unless I'm missing something (always a possibility), the kernel 
configurations do not provide a clear idea of component size. In other 
words, if I include "burfulgunk port support" in my kernel build, I'd 
like to have a rough idea of the component's size. I might not need to 
support the "burfulgunk", especially if it's a large component (for, 
say, a legacy port.)

I'm well aware that code sizes differ between platforms; I'm looking for 
general information, as a guideline to generating a small kernel.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

