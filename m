Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVBPMnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVBPMnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 07:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVBPMnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 07:43:42 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:5085 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262009AbVBPMnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 07:43:41 -0500
Date: Wed, 16 Feb 2005 13:43:36 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050216124336.GA27874@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

does anyone have some experiences with intel i855 video card and S3?

For me the binary driver from Intel works with S3 but only X server is restored
not the text console. 

With open source driver nothing is restored. I try to use s3_bios or s3_mode,
nothing helps. Using  vbetool and post causes backlight turn on but display is
full of garbage (vertical lines of different colors).

-- 
Luká¹ Hejtmánek
