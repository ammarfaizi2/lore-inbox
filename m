Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSEGMf2>; Tue, 7 May 2002 08:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSEGMf1>; Tue, 7 May 2002 08:35:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:53257 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315429AbSEGMf0>; Tue, 7 May 2002 08:35:26 -0400
Message-ID: <3CD7BB4F.3000409@evision-ventures.com>
Date: Tue, 07 May 2002 13:32:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita1.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.LNX.4.21.0205071345110.32715-100000@serv> <3CD7B826.7000000@evision-ventures.com> <20020507123647.GA283@pazke.ipt>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andrey Panin napisa³:
> On ???, ??? 07, 2002 at 01:19:02 +0200, Martin Dalecki wrote:

>>Well one question renames: Please name me one PCI based architecture
>>which contains IDE support and does not contain any special host chip
>>attached to the very same PCI bus as well.
> 
> 
> SiS 496/497 PCI chipset for i486's. It has integrated IDE controller,
> but this controller is not connected to PCI bus.

OK - That actually is an argument I follow. Thank you I will adjust
the code. (Not quite right jet maybe but I will do it.)

