Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUFZKAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUFZKAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 06:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUFZKAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 06:00:19 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:61622 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266284AbUFZKAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 06:00:16 -0400
Message-ID: <40DD4928.9090108@yahoo.com.au>
Date: Sat, 26 Jun 2004 20:00:08 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7-np1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/2.6.7-np1.gz

This applies against 2.6.7-mm2 and 2.6.7-bk8 with some offsets.

It contains some CPU scheduler and memory management work. If
you have any interactivity or swapping problems, please try it.

Make sure to give X a priority of about -10 for best results.

	renice -10 `pidof X`

