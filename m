Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTJ3DlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTJ3DlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:41:13 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:33971 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262149AbTJ3DlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:41:12 -0500
Message-ID: <3FA08853.5050402@cyberone.com.au>
Date: Thu, 30 Oct 2003 14:41:07 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler v17a
References: <3F913704.5040707@cyberone.com.au>
In-Reply-To: <3F913704.5040707@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/v17a/

More balancing fixes. I also incorporated some of Andrew Theurer's
ideas. I'm generally getting good numbers now, but using fairly
synthetic benchmarks.

Now would be a good time to test if anyone is interested. Thanks.


