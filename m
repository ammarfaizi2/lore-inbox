Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbTIJNKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTIJNKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 09:10:25 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:63500 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262983AbTIJNKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 09:10:24 -0400
Message-ID: <3F5F24AB.7060304@aitel.hist.no>
Date: Wed, 10 Sep 2003 15:18:35 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5 SMP (and mm6 and plain test5) got stuck during
 boot
References: <3F5847B7.9070308@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test4-mm4, mm6 and plain 2.6.0-test5 are all useless on my
dual celeron.  The machine get stuck when initscripts
tries to configure networking.  I can break
out of that with ctrl+c, but then it gets
stuck on something else shortly thereafter,
so I can't get as far as logging in.

The machine runs debian testing, and is fine with
2.6.0-test4.

Helge Hafting

