Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270730AbUJUOr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbUJUOr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 10:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270743AbUJUOrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:47:53 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:20611 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S270735AbUJUOpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:45:07 -0400
Date: Thu, 21 Oct 2004 16:45:05 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: AACRaid
Message-ID: <20041021144505.GB1580@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have ASR 2200S card with 6011 build of firmware.

Using 2.6.6 and 2.6.9 kernel it sometimes respond with:
aacraid:ID(0:02:0) Abort Time-out. Resetting bus.
aacraid:SCSI bus reset issued on channel 0
aacraid:Drive 0:0:0 online on container 0:
aacraid:Drive 0:1:0 online on container 0:
aacraid:Drive 0:2:0 online on container 0:
aacraid:Drive 0:3:0 online on container 0:

(The last I saw this it was during 2x dd if=/dev/sda of=/dev/null bs=1M
count=1024)

We had firmware 5xxx and we hoped that 6011 will fix this issue.

On the web of adaptec there is firmware version 7xxx. Is this version compatible
with linux driver? (as there is written that for windows you need upgraded
driver)

-- 
Luká¹ Hejtmánek
