Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTFPTf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTFPTf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:35:26 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:28907 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262143AbTFPTfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:35:23 -0400
Message-ID: <3EEE2293.6010304@techsource.com>
Date: Mon, 16 Jun 2003 16:03:31 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Coding technique question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I've seen this sort of thing done in the kernel:

do {
     ....
     code
     ....
} while (0);


What I was wondering is how this is any different from:

{
     ....
     code
     ....
}



