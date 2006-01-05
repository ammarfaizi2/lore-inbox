Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752101AbWAEHbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbWAEHbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWAEHbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:31:18 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:25435 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752101AbWAEHbR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:31:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mouz6YcTZ2NVkRlf1UwcfhOY2aj+FFUSUU5gV1ekOleNAicgXoTybFHamhbDKkF/UCS1votmyr4Xl5zRmCMYXJkSY7fNb0VGPwYQ+gwlstRmEGWoVsQ5rlGmNVZUnGtBTHl0l1MOL08YHt/jcMhLpF+s6pxTVgBaUZP9k7LcGMQ=
Message-ID: <81b0412b0601042331l5506117fw89360e50be3a423e@mail.gmail.com>
Date: Thu, 5 Jan 2006 08:31:15 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Possible GPL violation in Canyon CN-WF514 WLAN router
Cc: xerces8 <xerces8@butn.net>, tech@lists.gnumonks.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601050815030.10161@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <WorldClient-F200512251652.AA52540032@butn.net>
	 <WorldClient-F200601032031.AA31410090@butn.net>
	 <81b0412b0601040707r355da9eey1b6332d0563dd3a4@mail.gmail.com>
	 <Pine.LNX.4.61.0601050815030.10161@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >$ file WF514-200713T5.img
> >WF514-200713T5.img: PPCBoot image
> >
> Why does not my "file" utility print that...!?
>
> # rpm -q file
> file-4.14-3

Mine is newer:
$ file --version
file-4.16
magic file from /usr/share/file/magic
