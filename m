Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSCRM6l>; Mon, 18 Mar 2002 07:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310737AbSCRM6c>; Mon, 18 Mar 2002 07:58:32 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:52449 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S310695AbSCRM60>; Mon, 18 Mar 2002 07:58:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Another entry for the MCE-hang list
In-Reply-To: <E16mvSb-0004q9-00@the-village.bc.nu>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Mon, 18 Mar 2002 13:56:37 +0100
Message-ID: <87n0x63ugq.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> > The "running ok" case, which came -after- the hang case, was 
>> > 2.4.19-pre3-BK-latest with gcc 3.0.4-MDK.
>> 
>> I'm using egcs-1.1.2. I've bailed out of gcc-2.95.3 because it's
>> buggy. 
>
> egcs-1.1.2 is known to miscompile some driver code and other oddments in
> 2.4. 

Oh, really?

| COMPILING the kernel:
| 
|  - Make sure you have gcc-2.91.66 (egcs-1.1.2) available.  gcc 2.95.2 may
|    also work but is not as safe, and *gcc 2.7.2.3 is no longer supported*.
|    Also remember to upgrade your binutils package (for as/ld/nm and company)
|    if necessary. For more information, refer to ./Documentation/Changes.

(2.4.18 linux/README)

linux/Documentation/Changes is more helpful, though.

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
