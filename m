Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbTIKI6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbTIKI6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 04:58:15 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:42191 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S261172AbTIKI6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 04:58:13 -0400
Message-ID: <3F60383B.6030406@cornell.edu>
Date: Thu, 11 Sep 2003 04:54:19 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030829 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harry Brueckner <hb@o-d.de>
CC: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: devfs with 2.6.0-test4 kernel
References: <196810000.1063269840@localhost.localdomain>
In-Reply-To: <196810000.1063269840@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Any ideas what might be wrong?

Modprobe is too verbose when it comes to devfs failures.
This is known issue, and Rusty Russel has a patch for modutils, but he 
hasn't merged it yet, I think (or has he?).



