Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUAKTns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUAKTnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:43:47 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:28801
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S265969AbUAKTnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:43:46 -0500
Message-ID: <4001A770.90309@tupshin.com>
Date: Sun, 11 Jan 2004 11:43:44 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krisztian VASAS <iron@ironiq.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and UML
References: <1073849631.1233.8.camel@kian.localdomain>
In-Reply-To: <1073849631.1233.8.camel@kian.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krisztian VASAS wrote:

>Hello all!
>
>Is there any way to get work the 2.6 kernel with UML?
>
>  
>
This exact question was asked earlier today. My answer:

http://usermodelinux.org/

Look at the second item called:
FAQ: "I'm tracing myself and I can't get out"

There is an associated patch which needs to be applied to the UML 
*guest* when running on a 2.6 host.

-Tupshin
