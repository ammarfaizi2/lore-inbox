Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSJ3JAI>; Wed, 30 Oct 2002 04:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSJ3JAI>; Wed, 30 Oct 2002 04:00:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262667AbSJ3JAH>;
	Wed, 30 Oct 2002 04:00:07 -0500
Message-ID: <3DBFA0F8.9000408@pobox.com>
Date: Wed, 30 Oct 2002 04:06:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: andersen@codepoet.org, Dave Cinege <dcinege@psychosis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org>	<200210300229.44865.dcinege@psychosis.com>	<3DBF8CD5.1030306@pobox.com>	<200210300322.17933.dcinege@psychosis.com>	<20021030085149.GA7919@codepoet.org> <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:

>Erik Andersen <andersen@codepoet.org> writes:
>  
>
>>IMHO the embedded world (as well as everyone else) wants initramfs --
>>it is a major improvement.
>>    
>>
>
>I guess I'm part of the `embedded world,' and I don't want _either_
>because they _both use RAM_!
>  
>
hehe :)

>[Well, OK, actually it'd be nice to have something like initramfs + some
>other sort of fetch-the-bits-directly-from-ROM FS which I could
>mix-n-match; anyway initramfs has got to be better than initrd...]
>  
>

It should be pretty easy to populate initramfs from ROM...

    Jeff




