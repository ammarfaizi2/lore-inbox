Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVGFIU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVGFIU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVGFIUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:20:25 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:9752 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262136AbVGFGkL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:40:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p66yB5wc7dhV9qVEzt2fRY/DduLK1RMIiEpk/KohNcTUg2xbCKk0kHP3m+MqjlA2MH974DblTXN1m9GEHjBMGHUwb3SejarWErYx/J510E7dSbiybdMPPdIZwhL7icKCUKxzoLwJtwrUVnrHoiDyj7o1OcqTMxa5E+26w6P0fYM=
Message-ID: <84144f02050705234074ff7b99@mail.gmail.com>
Date: Wed, 6 Jul 2005 09:40:03 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164393426@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <nigel@suspend2.net> <11206164393426@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> As requested, here are the patches that form Suspend2, for review.
> 
> I've tried to split it up into byte size chunks, but please don't expect
> that these will be patches that can mutate swsusp into Suspend2. That
> would roughly equivalent to asking for patches that patch Reiser3 into
> Reiser4 - it's a redesign.

Please consider putting diffstat in the patches. They make navigating
large patchsets easier.

                               Pekka
