Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269991AbRHJTml>; Fri, 10 Aug 2001 15:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269989AbRHJTmb>; Fri, 10 Aug 2001 15:42:31 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:39012 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269984AbRHJTmX>; Fri, 10 Aug 2001 15:42:23 -0400
Date: Fri, 10 Aug 2001 15:42:16 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mike@bigstorage.com>, <kevin@bigstorage.com>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <20010726041821.C19238@vestdata.no>
Message-ID: <Pine.LNX.4.33.0108101541230.5531-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2001, Ragnar Kjørstad wrote:

> Did you forget something in your patch, or was it not supposed to work
> on ia32?
>
> This is kind of urgent, because I will temporarely be without testing
> equipment pretty soon. Tips are appreciated!

Please try it without a modular kernel.

		-ben

