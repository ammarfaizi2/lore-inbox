Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSGCDQy>; Tue, 2 Jul 2002 23:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316592AbSGCDQx>; Tue, 2 Jul 2002 23:16:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315419AbSGCDQw>;
	Tue, 2 Jul 2002 23:16:52 -0400
Message-ID: <3D226E86.695D27F3@zip.com.au>
Date: Tue, 02 Jul 2002 20:24:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: khromy <khromy@lnuxlab.ath.cx>
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: sync slowness. ext3 on VIA vt82c686b
References: <20020703022051.GA2669@lnuxlab.ath.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

khromy wrote:
> 
> When I copy a file(13Megs) from /home/ to /tmp/, sync takes almost 2 minutes.
> When I copy the same file to /usr/local/, sync returns almost right away.

Gad.  Please, mount those filesystems as ext2 and retest.

-
