Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbTCGBZY>; Thu, 6 Mar 2003 20:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCGBZY>; Thu, 6 Mar 2003 20:25:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64783 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261321AbTCGBZW>; Thu, 6 Mar 2003 20:25:22 -0500
Message-ID: <3E67F76E.4050709@zytor.com>
Date: Thu, 06 Mar 2003 17:35:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
References: <20030307001655.GB13766@kroah.com> <Pine.LNX.4.44.0303070156430.32518-100000@serv> <3E67F03F.2070902@zytor.com> <Pine.LNX.4.44.0303070215490.32518-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0303070215490.32518-100000@serv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> 
> Why would it be awkward? libgcc has the same problem, so they added this 
> paragraph:
> 
> In addition to the permissions in the GNU General Public License, the
> Free Software Foundation gives you unlimited permission to link the
> compiled version of this file into combinations with other programs,
> and to distribute those combinations without any restriction coming
> from the use of this file.  (The General Public License restrictions
> do apply in other respects; for example, they cover modification of
> the file, and distribution when not linked into a combine
> executable.)
> 
> Why can't we do something similiar?
> 

Why does it matter?

> 
>> Furthermore, I'm the author of most of the
>>code in there, and if someone really wants to rip it off it's not a huge
>>deal to me.
> 
> If it becomes part of the kernel (and a core part, not just some driver), 
> it would be awkward to have a completely different license, so this should 
> not be done without a very good reason.
> 

Why is it awkward?

	-hpa


