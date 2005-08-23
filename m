Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVHWDBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVHWDBF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 23:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVHWDBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 23:01:05 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52984 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751200AbVHWDBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 23:01:04 -0400
Date: Mon, 22 Aug 2005 20:47:44 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Surround via SPDIF with ALSA/emu10k1?
In-reply-to: <4EuwG-3If-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <430A8E50.3030109@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4EuwG-3If-19@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zehetbauer wrote:
> Now I can either enable the 'SB Live Analog/Digital Output Jack' switch
> and use the SPDIF connector to my DD5.1 surround system OR mute this
> control and access/unmute the rear/center/LFE channels. Using analog
> cabling is not an option as the DTT2500 has no connector for the
> center/LFE channels.

If the speaker system has no analog input for those channels, then there 
is no way to play back content through them unless it is Dolby Digital 
encoded. (There's no way to put more than 2-channel audio through SPDIF 
unless it's encoded such as by Dolby Digital or DTS.) The sound card is 
not capable of doing this, so if the content is not Dolby Digital 
already, this would have to be handled by some software.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

