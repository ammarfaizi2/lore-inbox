Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWCVJdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWCVJdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCVJdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:33:20 -0500
Received: from fc-cn.com ([218.25.172.144]:55826 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751164AbWCVJdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:33:19 -0500
Message-ID: <442119CA.6020305@fc-cn.com>
Date: Wed, 22 Mar 2006 17:32:58 +0800
From: =?ISO-2022-JP?B?GyRCNzdNJhsoQg==?= <qiyong@fc-cn.com>
Organization: FCD
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "J. Bruce Fields" <bfields@fieldses.org>,
       Matheus Izvekov <mizvekov@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SubmittingPatches typo
References: <20060320125012.GA21545@elf.ucw.cz>	 <Pine.LNX.4.61.0603202056100.14231@yvahk01.tjqt.qr>	 <305c16960603201247p53718859ofa0e6d0355c9da1a@mail.gmail.com>	 <20060320210209.GD31512@fieldses.org> <1142939779.21455.43.camel@localhost.localdomain>
In-Reply-To: <1142939779.21455.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Nope.  It's actually one of the amusing places where there *is* no rule.
>>Plurals that end in s always get just the apostrophe.  But for singular
>>nouns that end in s, while I tend to think of "'s" as the default, some
>>people like to drop the final s if the result ("Sophocles's") would
>>otherwise sound awkward spoken aloud.
>>    
>>
>
>The definitive references have this to say
>
>US English: Strunk and White says it should be "Torvalds's" and that the
>apostrophe alone is used only for ancient particularly biblical names
>ending in -es/is  (eg Moses' laws)
>  
>

akpm is already saying "Linus's" in his *mm-commits*:

This patch was probably dropped from -mm because
it has already been merged into a subsystem tree
or into Linus's tree


(btw, when Americans made mistakes, their English became American English.)


>UK English: The Oxford Guide To Style says
>
>"Use 's after non-classical or non-classicizing personal names ending
>with an s or z sound). It also says that Torvalds' would be acceptable.
>
>
>So both agree that
>
>	Torvalds's
>
>is correct and that would appear to be the right choice to keep everyone
>both sides of the pond happy.
>
>Jan: Care to submit an updated patch as the original is indeed wrong ?
>
>Alan
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

