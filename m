Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266656AbRGLVRQ>; Thu, 12 Jul 2001 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266608AbRGLVRG>; Thu, 12 Jul 2001 17:17:06 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:29374 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S266603AbRGLVQ6>;
	Thu, 12 Jul 2001 17:16:58 -0400
Date: Thu, 12 Jul 2001 22:16:55 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Mike Harrold <mharrold@cas.org>, linux-kernel@alex.org.uk
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] More pedantry.
Message-ID: <521750299.994976214@[169.254.45.213]>
In-Reply-To: <200107122058.QAA15963@mah21awu.cas.org>
In-Reply-To: <200107122058.QAA15963@mah21awu.cas.org>
X-Mailer: Mulberry/2.1.0b1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

>> If you want real pedantry, I think you mean:
>>
>> > + *		None of the E1AP-E3AP errata is visible to the user.
>>
>> ('none' is singular - read 'not one')
>>
>> ... several times within this patch.
>
> No, he was right the first time. Errata is plural. Erratum is the
> singular.

As I just wrote to someone else:

Sure, "Erratum" is singular, "Errata" is plural,
but "none of the errata" is singular, just as "one of
the errata" is singular. So "one of the chairs is blue",
"none of the chairs is blue" (as opposed to "are blue")
despite "chairs" being plural. OED essentially
states (just checked) that the plural usage of none is acceptable
only where one means "not any persons" etc. rather than
"not any one" or "not any person".

Hence "Errata are visible to the user" but "None
of the errata is visible to the user".

This will have a huge effect on kernel performance,
of course... :-)

--
Alex Bligh
