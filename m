Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUBPGPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUBPGPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:15:21 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:8387 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S265354AbUBPGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:15:13 -0500
Message-ID: <40305FEF.40206@emergence.uk.net>
Date: Mon, 16 Feb 2004 06:15:11 +0000
From: Jonathan Brown <jbrown@emergence.uk.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> This is an fbcon bug afaik. James ? Most x86 users report me that
> garbage on top of screen at boot when taking over VGA. Just to make
> sure we are talking about the same thing, can you send me a picture
> of the garbage taken with a digital camera ?

I have a photo of the 2.6.2 radeonfb corrupting the text on boot.

http://emergence.uk.net/radeonfb_corruption.jpeg

It was taken on an IBM X31.

Jonathan Brown

