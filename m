Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318130AbSHDIYQ>; Sun, 4 Aug 2002 04:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSHDIYQ>; Sun, 4 Aug 2002 04:24:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6412 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318130AbSHDIYQ>;
	Sun, 4 Aug 2002 04:24:16 -0400
Message-ID: <3D4CE7C2.A2393F19@zip.com.au>
Date: Sun, 04 Aug 2002 01:37:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30: buffer layer error at page-writeback.c:417
References: <200208020726.51659.tomlins@cam.org> <20020803190734.GB1548@niksula.cs.hut.fi> <20020804081452.GC1548@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> 
> buffer layer error at page-writeback.c:417
> Pass this trace through ksymoops for reporting

Is that on the ramdisk driver?
