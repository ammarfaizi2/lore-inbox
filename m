Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTHTWVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbTHTWVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:21:42 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:15828 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262257AbTHTWVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:21:38 -0400
Message-ID: <3F43F442.20404@sun.com>
Date: Wed, 20 Aug 2003 15:20:50 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: autofs@linux.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: autofs and namespaces
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For lack of clear insight into this, I thought I might put this out for 
opinions.

We're examining autofs and issues customers are having with it.  One of 
the issues that came up during discussions of things we can do is 
namespaces.

Does anyone have any ideas how namespaces and autofs ought to play 
together?  There are some obvious answers, but it seems to me that they 
might not be correct.

Anyone out there want to throw some ideas out?  We can just ignore it, 
but that isn't exactly nice.  What we really need is some guidance on 
what kind of sematics are "correct".

Tim


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

