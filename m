Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTLIBFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 20:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbTLIBFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 20:05:41 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:29853 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S262228AbTLIBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 20:05:38 -0500
Message-ID: <3FD51FDC.30904@kc.rr.com>
Date: Mon, 08 Dec 2003 19:05:32 -0600
From: hemp4fuel <hemp4fuel@kc.rr.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031204 Thunderbird/0.4RC2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test11 java application memory usage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.0-test11 with a duron 1.3ghz with 630mb ram using 
reiserfs and suns 1.4.2_01 jre, with 2.4.xx kernels the java based 
application I run used around 35-50mb memory, with the 2.6.0-test11 it 
goes right to 250mb and rises from there.  When I revert back to 2.4.23 
it is back to 35-50mb memory usage.

Dustin
