Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTKKEXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTKKEXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:23:06 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:16630 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S264246AbTKKEXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:23:03 -0500
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031110195433.4331b75e.akpm@osdl.org>
References: <1068519213.22809.81.camel@soul.jpj.net>
	 <20031110195433.4331b75e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1068523936.22800.101.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 23:12:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Now that I'm looking for it, however, I 
>> do note extremely elevated iowait numbers during a bonnie++ run. 

Note, however, that I do not see them during the NFS and Samba tests
under 2.4, only 2.6.0-testx

-Paul

