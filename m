Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271877AbRIEJuW>; Wed, 5 Sep 2001 05:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271888AbRIEJuM>; Wed, 5 Sep 2001 05:50:12 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:44972 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271877AbRIEJt6>;
	Wed, 5 Sep 2001 05:49:58 -0400
Date: Wed, 05 Sep 2001 10:50:14 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: David Schwartz <davids@webmaster.com>, Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: Linux 2.4.9-ac6
Message-ID: <1257554973.999687013@[169.254.198.40]>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMGEBNDLAA.davids@webmaster.com>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMGEBNDLAA.davids@webmaster.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	I think, perhaps, the logic should be that a module
>> shouldn't taint the kernel if:
>>
>> 	1) The user built the module from source on that machine, OR
>>
>> 	2) The module source is freely available without restriction
>
> 	I just realized two things. One, there's a strong argument that this
> should be an AND, not an OR.

And as all distributions would fail (1) in initial form, all
distributions would result in tainted kernels. Is this the
intent?

--
Alex Bligh
