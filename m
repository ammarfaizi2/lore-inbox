Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314578AbSDTHzT>; Sat, 20 Apr 2002 03:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314579AbSDTHzS>; Sat, 20 Apr 2002 03:55:18 -0400
Received: from mail.getnet.net ([63.137.32.10]:64472 "HELO mail.getnet.net")
	by vger.kernel.org with SMTP id <S314578AbSDTHzS>;
	Sat, 20 Apr 2002 03:55:18 -0400
Message-ID: <3CC11EE4.10504@westek-systems.com>
Date: Sat, 20 Apr 2002 00:55:16 -0700
From: Art Wagner <awagner@westek-systems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre7-ac2
In-Reply-To: <200204200038.g3K0c5110782@devserv.devel.redhat.com> <3CC0E2E9.3090600@westek-systems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Art Wagner wrote:
Oooops;
please disregard my previous post. I was compiling with my head up my a__.
Forgot to do "make xconfig" before "make bzImage".
Excuse me.

Art

> Hi;
> There seems to be a problem with compiling 2.4.19-pre7-ac2. My Redhat 
> (Skipjack Beta 2)
> system fails make bzImage with the following messages;
> gcc -Wall -Wstrict-prototypes =O2 -fomit-frame-pointer -o 
> scripts/split-include script-include.c
> make:  *** No rule to make targtet 'include/linux/autoconfig.h', 
> needed by 'include/config/MARKER'  Stop
> make:  *** Waiting for unfinished jobs........
> Art Wagner
>


