Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTJ2Gzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 01:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTJ2Gzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 01:55:31 -0500
Received: from gatesrv.RZ.UniBw-Muenchen.de ([137.193.11.27]:56752 "EHLO
	gatesrv.RZ.UniBw-Muenchen.de") by vger.kernel.org with ESMTP
	id S261898AbTJ2Gza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 01:55:30 -0500
Message-ID: <3F9F63B1.9090606@unibw-muenchen.de>
Date: Wed, 29 Oct 2003 07:52:33 +0100
From: =?ISO-8859-1?Q?Christian_K=F6gler?= 
	<christian.koegler@unibw-muenchen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 usbserial/pl2303 oops
References: <3F9F0753.10207@unibw-muenchen.de> <20031029034255.GA11297@kroah.com>
In-Reply-To: <20031029034255.GA11297@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Oct 29, 2003 at 01:18:27AM +0100, Christian Kögler wrote:
>  
>
>>I have got the same problem with my usb-towitoko (pl2303).
>>I had this bug with 2.4.20, 21 and 22
>>After reading, an oops appeared.
>>    
>>
>
>Again, try 2.4.23-pre8.  Let me know if that fixes it for you or not.
>  
>
Thats great, no oops!

But the libchipchard project doesn't work. After starting the chipcardd, 
I get this error:
"Mutex destroy failure: Device or resource busy"
But that could also be a bug in libchipcard or libtowitoko.

Chris

