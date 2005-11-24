Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030619AbVKXIcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030619AbVKXIcs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVKXIcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:32:48 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:46149 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030625AbVKXIcS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:32:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yd7+PRhBfyGW1OzyxxEfzu8kqXwLlesvTC9i05hlIqE/Kvv3x/qewL90OarS36lT/Ry7r3ZbXNqmGfgREq5hI3HYWV/TFVCrrev28sTCfaGdna4V6/3yzVGEL0yGP6kBLXos4AP1CNqBx59CQ7bTtiuh2iN5/O3Bp6f2B/fmJz4=
Message-ID: <cda58cb80511240032q7e4fbc67l@mail.gmail.com>
Date: Thu, 24 Nov 2005 09:32:17 +0100
From: Franck <vagabon.xyz@gmail.com>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
	 <cda58cb80511220658n671bc070v@mail.gmail.com>
	 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2005/11/22, Nicolas Pitre <nico@cam.org>:
> Please consider using the MTD mailing list next time (you certainly read
> about it on the MTD web site).
>

I did....

> Yes.  It was tested on ARM only though.  Some architectures like i386
> for example might need special tricks to implement this.
>

do you know why ? What was the gain on ARM ?

Thanks
--
               Franck
