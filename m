Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUGZKZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUGZKZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUGZKZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:25:38 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:4476 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265148AbUGZKZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:25:36 -0400
Message-ID: <4104DC13.3050201@yahoo.com.au>
Date: Mon, 26 Jul 2004 20:25:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc2-np1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/2.6.8-rc2-np1/

There is also a patch against 2.6.8-rc1-mm1. The naming scheme is a bit
confused at the moment :(


Anyway a lot more changes since I last announced a release. Memory manager
is working much better on bigger memory systems and highmem systems now.
If anyone knows of any meaningful pagecache intensive tests, let me know.
Better yet, try it and let me know where it performs worse than vanilla!
