Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314658AbSEBRRu>; Thu, 2 May 2002 13:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314661AbSEBRRt>; Thu, 2 May 2002 13:17:49 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:58241 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S314658AbSEBRRr>;
	Thu, 2 May 2002 13:17:47 -0400
Message-ID: <3CD17436.8070309@bcgreen.com>
Date: Thu, 02 May 2002 10:15:34 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020427
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Bill Davidsen <davidsen@tmr.com>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org> <Pine.LNX.3.96.1020429173812.26335B-100000@gatekeeper.tmr.com> <20020502034530.GT574@matchmail.com> <3CD0F846.3070605@bcgreen.com> <20020502154046.GU574@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)

Mike Fedyk wrote:
> On Thu, May 02, 2002 at 01:26:46AM -0700, Stephen Samuel wrote:
> 
>>I ran a similar type of test on a 2.4.9.31 (redhat 7.1 ) kernel.
>>With the CD on HDD, I could read off of HDA just peachy while
>>the system was choking on a scratched (aol) cd.
>>
>>I did a WC of a 300MB file (only 256MB of ram on the system,
>>so that's guaranteed to not fit in any cache).
>>
>>Times to read the file were statistically equivalent whether
>>the system was choking on the CD or not.
> 
> 
> Great, can you post the lspci output for your IDE chipset(s)?


-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

