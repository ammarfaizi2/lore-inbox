Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVDDIvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVDDIvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDDIvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:51:49 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:10887 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261183AbVDDIvk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:51:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qIep0c8nVwIoLuoTmnrrFAX9iPrOpdyIblLhnDKBzEkBeSuxb4L0xKkpPdMLm/N28uZjLBB/2Kg8LX0AG/DnFWdJG/b6z8okpT1D4pRvaOfOh+tv2Qn3+DIW/1raB8rvBm9b2AKnjpX89kxX5qcCEQol12fGW2QLKP7O7Q5q6cM=
Message-ID: <59ab6ac1050404015133699168@mail.gmail.com>
Date: Mon, 4 Apr 2005 10:51:39 +0200
From: =?ISO-8859-1?Q?Jose_=C1ngel_De_Bustos_P=E9rez?= 
	<jadebustos@gmail.com>
Reply-To: =?ISO-8859-1?Q?Jose_=C1ngel_De_Bustos_P=E9rez?= 
	  <jadebustos@gmail.com>
To: Triffid Hunter <triffid_hunter@funkmunch.net>
Subject: Re: A problem with kswapd
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4250F5CB.4070605@funkmunch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <59ab6ac105040400423fefd96a@mail.gmail.com>
	 <4250F5CB.4070605@funkmunch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 10:07 AM, Triffid Hunter <triffid_hunter@funkmunch.net> wrote:
> try 2.4.30 which has just been released (unchanged from 2.4.30-rc4)
> 

Sorry kernel is 2.4.21.

We have other machines in the "same" conditions and they have a normal
behavour. We don't know the reason for this awkward behavour.

I don't know if we can change to kernel 2.4.20, its a production
machine and I have to check if that kernel has official support.

> Jose Ángel De Bustos Pérez wrote:
> > Hi,
> >
> > I have a problem with kswapd and I didn't find anything in the
> > archives of the list (I hope not having missed someone).
> >
> > kswapd is using 100% of CPU in a suse sles8 with kernel 2.4.241. This
> > machine has its FS under LVM and ResiserFS, except for /boot which is
> > in ext2.
> >
> > Any idea? Thanks in advance.
> 


-- 
____________________________________
Atentamente, José Angel de Bustos Pérez

jadebustos@linuxmail.org
jadebustos@gmail.com

Jabber ID jadebustos@jabber.org
ICQ ID 200368358
