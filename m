Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWFTUky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWFTUky (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWFTUky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:40:54 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:48706 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750870AbWFTUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:40:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=azvghumyqdBWKg3hZhn3cIy3m3IyPk9CU2x4tjnS/2+RAWmQphvuximrApiyyeJHkn8mlf7WAARS5IPZKFX6Rahsb9967RkIFWFczSXtKh3tFf+XiXR1ZxA8cRzlUjmNyFYPpzpt+al5K3YNpOU6a1ngUWL03FyZQnjFFXnyI24=
Message-ID: <44985D51.8050200@gmail.com>
Date: Tue, 20 Jun 2006 14:40:49 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
References: <448DB57F.2050006@gmail.com>	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>	<44944D14.2000308@gmail.com>	<20060619222223.8f5133a9.akpm@osdl.org>	<44985321.3020609@gmail.com> <20060620131440.9c9b0999.rdunlap@xenotime.net>
In-Reply-To: <20060620131440.9c9b0999.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 20 Jun 2006 13:57:21 -0600 Jim Cromie wrote:
>
>   
>> Andrew Morton wrote:
>>     
>>> On Sat, 17 Jun 2006 12:42:28 -0600
>>> Jim Cromie <jim.cromie@gmail.com> wrote:
>>>
>>> Fixup patches agains next -mm would be suitable.  Please keep them
>>> super-short: basically one-patch-per-review-comment.  That way I can easily
>>> instertion-sort the patches into place and we retain a nice patch series.
>>>
>>>   
>>>       
>> OK.  Just so Im clear, Ill patch against the tail of the set (ie -mm1), 
>> and you'll push them forward into the
>>     
>
> WTH?  "you'll" ??
>
>   

are we talking apostrophes here, or division of labor ?
If the latter, what have I missed ?
Andrew specifically said 'patch against next -mm', I intended to follow 
his instructions.


