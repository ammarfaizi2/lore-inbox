Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTEFOGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTEFOFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:05:04 -0400
Received: from watch.techsource.com ([209.208.48.130]:44252 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263729AbTEFOD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:03:56 -0400
Message-ID: <3EB7C490.5040803@techsource.com>
Date: Tue, 06 May 2003 10:20:00 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Another question about thrashing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There didn't seem to be much interest in my earlier post about kernel 
behavior when swap thrashing.

So my question is, are we not concerned about system behavior when one 
process uses so much memory that it grinds everything else to a halt?

It appears that a thrashing process is being given more preferential 
treatment than it should.

