Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271261AbTGPXYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271267AbTGPXYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:24:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15514 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271261AbTGPXWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:22:44 -0400
Message-ID: <3F15E1B5.4020206@pobox.com>
Date: Wed, 16 Jul 2003 19:37:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
References: <20030716225826.GP2412@rdlg.net>
In-Reply-To: <20030716225826.GP2412@rdlg.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:
> 
> I have a soundblaster Live.  I've historically used the OSS drivers as
> they've worked well for me.  I just tried to load the emu10k1 which
> loads without error, but mpg123 says it can't open the default sound
> device.


I am biased, but, it would be nice for people to start testing the 
"official" 2.6 sound drivers, ALSA.  The ALSA API has many benefits over 
OSS, but needs wide-spread testing and validation.

	Jeff, who is long tired of hacking on OSS drivers :)



