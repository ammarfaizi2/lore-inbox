Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288165AbSACD1B>; Wed, 2 Jan 2002 22:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288163AbSACD0w>; Wed, 2 Jan 2002 22:26:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43908 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S288166AbSACD0m>; Wed, 2 Jan 2002 22:26:42 -0500
Message-ID: <3C33CF71.4060202@videotron.ca>
Date: Wed, 02 Jan 2002 22:26:41 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com> <3C33A4EC.1040300@videotron.ca> <20020103002827.GA4462@kroah.com> <3C33AF4F.7000703@videotron.ca> <20020103013231.GA4952@kroah.com> <3C33BD88.3010903@videotron.ca> <20020103030356.GA5313@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Jan 02, 2002 at 09:10:16PM -0500, Roger Leblanc wrote:
>
>>umount seg-faults while unmounting /proc/bus/usb! Then modprobe also 
>>seg-faults while unloading usb-uhci!!! But the system stays up.
>>After that, I cannot make my scanner to work even if I run 
>>".../init.d/usb start".
>>
>
>Can you run that first oops through ksymoops and send it.  Actually do
>it for both oopses.
>
Oops? I know about cores but I don't know about oopses. I'm only a C++, 
hight level, OO developer. Sorry ;-). Can you explain please?

>>B.T.W. Did I tell you that I can bring the kernel down just by turning 
>>the scanner off and then back again?
>>
>
>Hm, sounds like the scanner driver has some problems :)
>You might email the author with this info and see if he has any ideas.
>
I'll do that

Thanks

Roger


