Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVD3Arn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVD3Arn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbVD3Ari
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:47:38 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:61660 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S263097AbVD3Aqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:46:45 -0400
Date: Sat, 30 Apr 2005 02:46:40 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Alsa Realtek-HDA
Message-ID: <20050430004640.GB13896@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 2.6.12-rc3 kernel using alsa drivers.

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04) (8086:2668)

Using alsa interface, it's ok, but using OSS interface (/dev/dsp) it produces
noise together with sound.

Is it a known problem?

-- 
Luká¹ Hejtmánek
