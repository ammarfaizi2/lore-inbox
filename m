Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUHTNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUHTNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUHTNuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:50:05 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:27454 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267974AbUHTNtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:49:15 -0400
Message-ID: <d577e56904082006495a66179c@mail.gmail.com>
Date: Fri, 20 Aug 2004 09:49:11 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       b.zolnierkiewicz@elka.pw.edu.pl, alan@lxorguk.ukuu.org.uk
In-Reply-To: <4125FE92.nail8LD4QVROS@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408191732.i7JHWSkL005470@laptop14.inf.utfsm.cl> <4125FE92.nail8LD4QVROS@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 15:37:22 +0200, Joerg Schilling
<schilling@fokus.fraunhofer.de> wrote:
> The Linux kernel is broken because it it did break existing interfaces - period.

What you really meant to say is that they fixed a previously broken
interface so that it worked correctly; which just happened to break
your poorly written app. If you had any shread of self respect, you'd
silently fix cdrecord without a further mention of it here.

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
