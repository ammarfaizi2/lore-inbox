Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312417AbSCYMxw>; Mon, 25 Mar 2002 07:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312416AbSCYMxd>; Mon, 25 Mar 2002 07:53:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33551 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312390AbSCYMx3>;
	Mon, 25 Mar 2002 07:53:29 -0500
Message-ID: <3C9F1D7E.5030207@mandrakesoft.com>
Date: Mon, 25 Mar 2002 07:52:14 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished.
In-Reply-To: <5.1.0.14.2.20020325013452.03e53630@pop.cus.cam.ac.uk> <6451.1017045127@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>aia21@cam.ac.uk said:
>
>> And it should work  on both little endian and big endian
>>architectures, and both on 32 and 64  bit architectures. Note, only
>>ia32 has actually been tested and there may  be problems with
>>architectures not supporting unaligned accesses. Any  volunteers for
>>non-ia32 architectures?
>>
>
>All architectures should support unaligned accesses.
>

Yeah well... I continue to do get_unaligned() in my net drivers where 
prudent :)

    Jeff




