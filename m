Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291599AbSBHPJX>; Fri, 8 Feb 2002 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291603AbSBHPJO>; Fri, 8 Feb 2002 10:09:14 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64785 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291599AbSBHPJE>; Fri, 8 Feb 2002 10:09:04 -0500
Message-ID: <3C63EA0A.6090605@evision-ventures.com>
Date: Fri, 08 Feb 2002 16:08:58 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020129
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Wichert Akkerman <wichert@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide cleanup
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <3C63C5EF.4050403@evision-ventures.com> <20020208133755.A10250@suse.cz> <3C63CF54.9090308@evision-ventures.com> <a40okb$mds$1@picard.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:

>In article <3C63CF54.9090308@evision-ventures.com>,
>Martin Dalecki  <dalecki@evision-ventures.com> wrote:
>
>>The _t at the end of type names is a POSIX habit of markup for system 
>>defined types - this should *NOT* be used in user land programms but is OK for
>>the kernel.
>>
>
>Why, I don't see that. Everyone should use whatever notation he/she
>feels most comfortable with.
>

If he intends (or loves to)  to have name-sapce clashes with system 
headers he should feel free indeed.

