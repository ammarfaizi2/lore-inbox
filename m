Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTF1OZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbTF1OZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 10:25:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62689 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265226AbTF1OZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 10:25:24 -0400
Message-ID: <3EFDA8A2.8090008@pobox.com>
Date: Sat, 28 Jun 2003 10:39:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Onur Kucuk <onur@kablonet.com.tr>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-ac4 & cm9739 & SATA
References: <3EFCD206.2020501@kablonet.com.tr> <3EFCF119.7000809@pobox.com> <3EFD7B14.7060307@kablonet.com.tr>
In-Reply-To: <3EFD7B14.7060307@kablonet.com.tr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Onur Kucuk wrote:
>  Done, working fine, thank you
> 
>  Now I have a shiny new sda instead of the old hde 

cool!  :)


>  And just if I can find a way to make the sound work properly

This is i810_audio a.k.a. ICH5 audio, yes?

If so, (a) ALSA works and (b) I hope to have i810_audio fixed in a week 
or so.

	Jeff



