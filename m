Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbVIGURM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVIGURM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVIGURL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:17:11 -0400
Received: from [85.8.12.41] ([85.8.12.41]:20096 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751306AbVIGURK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:17:10 -0400
Message-ID: <431F4AC4.9030206@drzeus.cx>
Date: Wed, 07 Sep 2005 22:17:08 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       linux-pm@osdl.org
Subject: Re: swsusp doesn't suspend devices
References: <431ECCE3.8080408@drzeus.cx> <200509072203.19283.rjw@sisk.pl>
In-Reply-To: <200509072203.19283.rjw@sisk.pl>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

>On Wednesday, 7 of September 2005 13:20, Pierre Ossman wrote:
>  
>
>>It would seem that swsusp doesn't properly suspend devices, or more
>>precisely it wakes them up again before suspending the machine.
>>    
>>
>
>Yes, it does.  By design.
>
>  
>

That seems counter-productive, so I'm obviously missing something.
