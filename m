Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVGHBqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVGHBqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 21:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVGHBqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 21:46:18 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:53932
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261363AbVGHBqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 21:46:17 -0400
Message-ID: <42CDCCCC.9050309@linuxwireless.org>
Date: Thu, 07 Jul 2005 19:46:04 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Clemens Koller <clemens.koller@anagramm.de>, Jens Axboe <axboe@suse.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up
References: <4msjB-DS-9@gated-at.bofh.it> <4mste-IL-1@gated-at.bofh.it> <4msME-SM-9@gated-at.bofh.it> <4msWl-Yq-5@gated-at.bofh.it> <4mtza-1vg-15@gated-at.bofh.it> <4mtII-1Ab-13@gated-at.bofh.it> <4mtSm-1FA-5@gated-at.bofh.it> <4mtSn-1FA-11@gated-at.bofh.it> <4mwx1-3N9-25@gated-at.bofh.it> <4mx9A-4qm-1@gated-at.bofh.it> <4nzCr-6fN-19@gated-at.bofh.it> <4nI36-527-9@gated-at.bofh.it> <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
In-Reply-To: <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:

>Clemens Koller <clemens.koller@anagramm.de> wrote:
>
>  
>
>>Well, sure, it's not a notebook HDD, but maybe it's possible
>>to give headpark a more generic way to get the heads parked?
>>    
>>
>
>I remember my old MFM HDD, which had a Landing Zone stored in the BIOS to
>which the park command would seek. Maybe you could do something similar
>and park the head on the last cylinder if the other options fail.
>  
>
This makes me wonder... If you replace the internal HD with a non IBM or 
IBM supported Hard Drive, will it still park the head and will it 
support all the stuff?

.Alejandro
