Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266690AbUFRSjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266690AbUFRSjD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266710AbUFRSjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:39:02 -0400
Received: from mailhost.ulb.ac.be ([164.15.59.220]:22934 "EHLO
	bonito.ulb.ac.be") by vger.kernel.org with ESMTP id S266690AbUFRSgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:36:47 -0400
Message-ID: <40D3363D.8040402@vub.ac.be>
Date: Fri, 18 Jun 2004 20:36:45 +0200
From: Michael Van Damme <michael.vandamme@vub.ac.be>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 snmp: Bridge does not support ioctl 0x8947
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Every time I run mrtg (which uses snmp), I see al lot of these messages 
in my kernel logs (running kernel 2.6.7)

Jun 18 20:19:28 localhost Bridge does not support ioctl 0x8947

This didn't happen under 2.6.6. I tried upgrading net-snmp to version 
5.1.1, but that didn't help.
Everything seems to work ok, though, including snmp.

Cheers,
Michael




