Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTESRwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTESRwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:52:47 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:64906 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S262562AbTESRwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:52:46 -0400
Message-ID: <3EC91CF2.7020602@blue-labs.org>
Date: Mon, 19 May 2003 14:05:38 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519124539.B8868@infradead.org> <1053348984.9142.98.camel@workshop.saharact.lan> <20030519140617.A15587@infradead.org>
In-Reply-To: <20030519140617.A15587@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about not passing the buck off to "the vendor" and helping "this 
vendor" make sanitized headers.

Not everybody copies RH and changes the text files from "RH" to "my 
distribution name".

Gentoo is my very strongly preferred distribution and I have a lot of 
respect and admiration for Martin for stepping in this bull*shit pool 
and trying to get something accomplished.

David

Christoph Hellwig wrote:

>On Mon, May 19, 2003 at 02:56:25PM +0200, Martin Schlemmer wrote:
>  
>
>>Point is just that people like you keep on bitching about not
>>using sanitized kernel headers, but do nothing about it, or
>>until today have said nothing about 'sanitized headers'.
>>    
>>
>
>Why don't you just get the glibc-kernheaders package from rawhide
>(or the equivalent from your prefered distribution) and stop
>complaining? 
>


