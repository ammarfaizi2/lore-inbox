Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264924AbUF1M1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbUF1M1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbUF1M1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:27:20 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:53926 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264924AbUF1M1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:27:19 -0400
Message-ID: <40E00EA4.8060205@yahoo.com.au>
Date: Mon, 28 Jun 2004 22:27:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.7-np2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/2.6.7-np2.gz

This is against 2.6.7-mm3. I can do one against -bk if anyone would
like.

It should fix scheduler problems and compile problems in 2.6.7-np1.

It contains my CPU scheduler and memory management stuff. If anyone
is having swapping or interactivity problems, please try it out.
