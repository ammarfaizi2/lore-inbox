Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTIOL1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTIOL1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:27:49 -0400
Received: from [217.222.53.238] ([217.222.53.238]:22803 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S261249AbTIOL1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:27:48 -0400
Message-ID: <3F65A230.3020806@gts.it>
Date: Mon, 15 Sep 2003 13:27:44 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-t4/5] Error inserting module snd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

When inserting module snd, modprobe bails out saying

snd: Unknown parameter 'device_mode'

The result is that the sound is completely unavailable. This happens 
with -test4 and -test5 (and -test5-mm2), but it was OK up to -test3,
IIRC.

Sorry if this was already reported


-- 
Stefano RIVOIR




