Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266705AbUHIQ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266705AbUHIQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUHIQ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:26:14 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:13843 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266705AbUHIQ0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:26:11 -0400
Message-ID: <d577e5690408090926c9b3bf1@mail.gmail.com>
Date: Mon, 9 Aug 2004 12:26:10 -0400
From: Patrick McFarland <diablod3@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Cc: dwmw2@infradead.org, james.bottomley@steeleye.com,
       alan@lxorguk.ukuu.org.uk, axboe@suse.de, eric@lammerts.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200408091440.i79EeqrH010640@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408091440.i79EeqrH010640@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 16:40:52 +0200 (CEST), Joerg Schilling
<schilling@fokus.fraunhofer.de> wrote:
> People who use the official cdrecord know that they need to run cdrecord
> with root privilleges. People who run the bastardized version from SuSE
> don't know this and fail to write CDs.

This is why people should be using Debian to begin with. Debian asks
if you want to install cdrecord with suid so everyone can burn cds
without needing to be root first.

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
