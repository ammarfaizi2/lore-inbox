Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271318AbTGQBef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271302AbTGQBef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:34:35 -0400
Received: from remt30.cluster1.charter.net ([209.225.8.40]:37332 "EHLO
	remt30.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S271318AbTGQBec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:34:32 -0400
Message-ID: <3F1600AC.7020007@mrs.umn.edu>
Date: Wed, 16 Jul 2003 20:49:32 -0500
From: Grant Miner <mine0057@mrs.umn.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Can't boot 2.5.72 through 2.6-pre1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've tried 2.5.72 through 2.6-pre1 and they all display Uncompressing 
Linux... Ok, booting the kerenel!,
and then cease output.  I've tried compiling with "make allno", and with 
gcc 2.96 and gcc 3.3.1.  Binutils is 2.14.90.04.

