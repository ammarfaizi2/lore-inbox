Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270148AbTHJQ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTHJQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:59:15 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:59602 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S270148AbTHJQ7O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:59:14 -0400
Message-ID: <3F3679DD.2070108@Synopsys.COM>
Date: Sun, 10 Aug 2003 18:59:09 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3: sound problem with bzflag
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Starting with test3 I experience a sound problem: Playing
*.wav files is no problem, xmms works as expected (using
either Alsa or OSS driver), but bzflag can't play its sound
files anymore. Bzflag on kernel 2.6.0-test2 is fine.

Can anybody reproduce this problem?


Regards

Harri

