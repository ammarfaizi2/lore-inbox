Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288057AbSACA2I>; Wed, 2 Jan 2002 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSACA1C>; Wed, 2 Jan 2002 19:27:02 -0500
Received: from relais.videotron.ca ([24.201.245.36]:1787 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S288080AbSACAZS>; Wed, 2 Jan 2002 19:25:18 -0500
Message-ID: <3C33A4EC.1040300@videotron.ca>
Date: Wed, 02 Jan 2002 19:25:16 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock in kernel on USB shutdown
In-Reply-To: <3C33A22F.40906@videotron.ca> <20020103001816.GB4162@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH wrote:

>On Wed, Jan 02, 2002 at 07:13:35PM -0500, Roger Leblanc wrote:
>
>>It doesn't get that far. The first thing my init script (or Mandrake 8.1 
>>script) does at shutdown is to run modprobe -r on modules usb-ohci, 
>>usb-uhci and uhci. The system freeses when it gets to usb-uhci. It does 
>>it also if I run these commands on the command line.
>>
>
>Have you unloaded your scanner module before unloading the usb-uhci
>module?
>
No. Actually, I don't even know how it's called. How can I find out?

Thanks

Roger

>
>
>thanks,
>
>greg k-h
>


