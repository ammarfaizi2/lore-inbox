Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965311AbWADWok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965311AbWADWok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWADWok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:44:40 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:23592 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965312AbWADWoj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:44:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dhNANA7yRYQEmMeuP1hzjorwlQru+jeCfdifTu1BdXnvj3/MQ9JSCDHwMRlkJaDY/vjq5J0904LQPG7aYxBuNmahTDGv9Lk8fzRhVL+bOYxjP6aUcTj/oLjMrtpwEdz2S+qvItoto/bVv9j5kEwgASTRKVQmRQMmOb6INQ2NSbc=
Message-ID: <d120d5000601041444m5e4e75b5v4f32fb429bb9776c@mail.gmail.com>
Date: Wed, 4 Jan 2006 17:44:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 09/15] wistron_btns: Add Acer TravelMate 240 key mappings.
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1136413739.4430.32.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <0ISL00ELB95T6A@a34-mta01.direcway.com>
	 <d120d5000601041421y4965ae64tc4ce2c2cef92b9a5@mail.gmail.com>
	 <1136413739.4430.32.camel@grayson>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Ben Collins <ben.collins@ubuntu.com> wrote:
>
> If this is scheduled for entry, then I'll just let it go from there.
> Just wanted to make sure we weren't holding any patches back from the
> rest of the world.
>

I was going to ask Linus to merge in the next couple of days... I will
grab your patch for i8042 if you don't mind.

Anyway, if you'd like to check what staged for merging my git tree is here:

        rsync.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

--
Dmitry
