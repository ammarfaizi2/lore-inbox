Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTIMJ7C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTIMJ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:59:02 -0400
Received: from [144.139.35.54] ([144.139.35.54]:20097 "EHLO portal.frood.au")
	by vger.kernel.org with ESMTP id S262118AbTIMJ7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 05:59:01 -0400
Message-ID: <3F62EA61.1000804@bigpond.com>
Date: Sat, 13 Sep 2003 19:58:57 +1000
From: James Harper <james.harper@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: oops in inet_bind/tcp_v4_get_port
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a null pointer exception in the same routine when restarting slapd 
in 2.6.0-test5, and it hangs my system hard. I'm investigating now. If 
anyone has a patch already please send me a copy too!

thanks

James

