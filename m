Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287503AbSAEEJX>; Fri, 4 Jan 2002 23:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287502AbSAEEJO>; Fri, 4 Jan 2002 23:09:14 -0500
Received: from h00e02954cece.ne.mediaone.net ([24.91.228.68]:53380 "EHLO
	gonzo.amherst.genlogic.com") by vger.kernel.org with ESMTP
	id <S287500AbSAEEJD>; Fri, 4 Jan 2002 23:09:03 -0500
Message-ID: <3C367C83.2060404@mediaone.net>
Date: Fri, 04 Jan 2002 23:09:39 -0500
From: Sam Krasnik <genlogic@mediaone.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: atp870u and acard scsi HELP!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> i tried rewriting it myself...i cannot get it to insmod.
>> it just hangs...can anyone help? i am not very
>> knowledgeable of the scsi driver code ;-(
>>
>
> Umm the atp870u is supported in 2.2 and 2.4 by the default kernels.

...so one would think...yes it is supported technically, and the atp870u
driver does exist...but the 2.4 one does not work, that is a known fact.
browsing the forums, it seems that people were complaining about
 >2037 not working, but that the original one worked just fine.
some of the code has a different format in 2.4 than 2.2 and 2.0,
mostly the external stuff to load as modules...etc, but i can't get it 
to work.
so i needed help porting the old one into the new 2.4 framework
if you will.

regards,

--sam


