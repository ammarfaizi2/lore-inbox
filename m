Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265642AbUA0Tg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 14:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUA0Tds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 14:33:48 -0500
Received: from [195.23.16.24] ([195.23.16.24]:37579 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265642AbUA0TcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 14:32:04 -0500
Message-ID: <4016BC86.9020301@grupopie.com>
Date: Tue, 27 Jan 2004 19:31:18 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Weinehall <tao@debian.org>
Cc: "Joseph D. Wagner" <theman@josephdwagner.info>, Andi Kleen <ak@suse.de>,
       Rui Saraiva <rmps@joel.ist.utl.pt>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel> <p73bropfdgl.fsf@nielsen.suse.de> <200401271251.34926.theman@josephdwagner.info> <20040127191358.GI20879@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:

> On Tue, Jan 27, 2004 at 12:51:34PM -0600, Joseph D. Wagner wrote:
> 
>>>It seems that many files [1] in the Linux source have lines with
>>>trailing blank (space and tab) characters and some even have formfeed
>>>characters. Obviously these blank characters aren't necessary.
>>>
>>Actually, they are necessary.
>>
>>http://www.gnu.org/prep/standards_23.html
>>http://www.gnu.org/prep/standards_24.html
>>
> 
> Let me quote CodingStyle:
> 
> "First off, I'd suggest printing out a copy of the GNU coding standards,
>  and NOT read it.  Burn them, it's a great symbolic gesture."
> 
> That's how much relevance GNU's coding standards have to the kernel.
> 

And even if we did use GNU's coding standards (knock on wood :), where is the 
part that requires *trailing* spaces?

Only in languages like "whitespace" ( http://compsoc.dur.ac.uk/whitespace/ ) the 
trailing spaces have any meaning :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

