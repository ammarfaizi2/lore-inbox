Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276956AbRJ3R1d>; Tue, 30 Oct 2001 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbRJ3R1X>; Tue, 30 Oct 2001 12:27:23 -0500
Received: from [207.8.4.6] ([207.8.4.6]:7288 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S276956AbRJ3R1C>;
	Tue, 30 Oct 2001 12:27:02 -0500
Message-ID: <3BDEE301.3000008@interactivesi.com>
Date: Tue, 30 Oct 2001 11:27:29 -0600
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: TimO <hairballmt@mcn.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <01102920463500.03524@newton.cevio.com> <3BDE27BE.3569FE22@candelatech.com> <3BDE3360.80731876@mcn.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TimO wrote:

> Ugghh!  Don't confuse/equate MODULE_LICENSE with EXPORT_SYMBOL_GPL_ONLY;
> two different animals, two differnet goals.  See archives for more info.


What happens is a module is distributed as a combination of open-source .c 
files and closed-source .o files.  That is, it's "mixed source" - part of the 
driver is open-source and part is closed-source.  What happens if the 
open-source version of the driver is the only code that uses GPL-only symbols. 
  How is that handled?

