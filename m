Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUHSOuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUHSOuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHSOuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:50:06 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:56475
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266345AbUHSOpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:45:41 -0400
Message-ID: <4124BD14.90603@bio.ifi.lmu.de>
Date: Thu, 19 Aug 2004 16:45:40 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org, kernel@wildsau.enemy.org,
       diablod3@gmail.com
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner> <20040819131026.GA9813@ucw.cz> <4124AD46.nail80H216HKB@burner> <20040819135614.GA12634@ucw.cz> <4124B314.nail8221CVOE9@burner> <20040819141442.GC13003@ucw.cz>
In-Reply-To: <20040819141442.GC13003@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
> 
> 
>>I did talk to the official SuSE product manager 1.5 years ago and this person
>>just tried to take me as a clod.
>>
>>Do you really believe that I am doing all this before trying to find a decent 
>>discussion based solution? 
> 
> 
> That's really hard to believe, but on the other hand, when packaging my programs,
> SUSE people were always cooperating very well.
> 
> So, let's ask the SUSE'rs around there: is there any problem with adding such
> a notice to the cdrecord package?

There is already. cdrecord on SuSE 9.1 tells you:
Cdrecord-Clone-dvd 2.01a27 (i686-suse-linux) Copyright (C) 1995-2004 Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to http://www.suse.de/feedback
Note: The author of cdrecord should not be bothered with problems in this version.


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

