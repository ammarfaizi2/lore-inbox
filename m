Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSG2NIW>; Mon, 29 Jul 2002 09:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSG2NIV>; Mon, 29 Jul 2002 09:08:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:65295 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316903AbSG2NIV>; Mon, 29 Jul 2002 09:08:21 -0400
Message-ID: <3D453DE5.2020901@evision.ag>
Date: Mon, 29 Jul 2002 15:06:45 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
CC: martin@dalecki.de, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: /proc/pci removal?
References: <20020729131717.A25451@flint.arm.linux.org.uk>	<3D4532D5.1000706@evision.ag> <m2it2yn1ly.fsf@vador.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Vignaud wrote:
> Marcin Dalecki <dalecki@evision.ag> writes:
> 
> 
>>>I seem to vaguely remember that a while ago (2.3 days?) there was
>>>discussion about removing /proc/pci in favour of the lspci output,
>>>however there doesn't seem much in google groups about it (and
>>>marc seems useless with non-alphanumeric searches.)
>>
>>scanpci from XFree is using it as well. However i would rather still
>>like it to be gone despite this inconvenience.
> 
> 
>   neither gatos scanpci nor XFree86' scanpci do:

Confirmed. Apparently I forgot about the /bus/ in the path above.

