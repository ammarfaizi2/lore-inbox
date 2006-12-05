Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031005AbWLEUJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031005AbWLEUJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030945AbWLEUJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:09:51 -0500
Received: from mail.tmr.com ([64.65.253.246]:48091 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031005AbWLEUJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:09:50 -0500
Message-ID: <4575D2E5.3000401@tmr.com>
Date: Tue, 05 Dec 2006 15:13:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Florian Festi <florian@festi.info>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Meaning of keycodes unclear
References: <45753BB1.6030102@festi.info>
In-Reply-To: <45753BB1.6030102@festi.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Festi wrote:
> I am looking for the meaning of the following key codes as #defined in 
> include/linux/input.h. I need to know what hardware produces the keycode 
> and what happens/should happen when the corresponding key is pressed.

> KEY_MACRO

I presume this is the macro defining key, used on keyboards like the 
Gateway102. I thought it was handled internally and didn't send a 
keycode, but other keyboards had/have that feature as well.

Used G102 for application work, had the function keys both next-to and 
above the alpha keys, so you could bind up to 48 application functions 
and still have function keys as other things wanted them.

Hope that answers your question.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
