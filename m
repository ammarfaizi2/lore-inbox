Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUBUBYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 20:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUBUBYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 20:24:10 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:21429 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261468AbUBUBYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 20:24:08 -0500
Message-ID: <4036B33B.2000405@metaparadigm.com>
Date: Sat, 21 Feb 2004 09:24:11 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Nischal Saxena <nischal_saxena@da-iict.org>, linux-kernel@vger.kernel.org
Subject: Re: transferring data through the sound card
References: <200402161800.i1GI0ul15334@mail.da-iict.org> <20040220234601.GC32153@elf.ucw.cz>
In-Reply-To: <20040220234601.GC32153@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/04 07:46, Pavel Machek wrote:
> Hi!
> 
> 
>> how is it possible to transfer data across two PC using the sound card.
> 
> 
> It would be actually pretty nice project ;-). Its not at all easy.
> 
> I was able to transfer data using dtmf and dtmf decoder (PC beeper to
> internal microphone of notebook), but with advanced software much
> better speed should be possible.

I believe it's already being worked on (as a subset of what the
GNU radio project is doing - software modulation/demodulation -
just removing the requirement for down conversion):

   http://www.gnu.org/software/gnuradio/gnuradio.html

~mc
