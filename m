Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSJIOGh>; Wed, 9 Oct 2002 10:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJIOGh>; Wed, 9 Oct 2002 10:06:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41988 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261733AbSJIOGg>;
	Wed, 9 Oct 2002 10:06:36 -0400
Message-ID: <3DA4392B.8070204@pobox.com>
Date: Wed, 09 Oct 2002 10:11:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: BK kernel commits list
References: <20021009.045845.87764065.davem@redhat.com>  <18079.1034115320@passion.cambridge.redhat.com> <20021008.175153.20269215.davem@redhat.com> <200210091149.g99BnWQ5000628@pool-141-150-241-241.delv.east.verizon.net> <7908.1034165878@passion.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of suggestions for the output...

The BitKeeper header is unfortunately less than useful at times -- often 
multiple cset descriptions wind up in the header -- so I would suggest 
exporting the patch with "-hdu" instead of "-du", and then manually 
adding the changeset info and description at the top.

Also, diffstat output prepended would be nice too.

