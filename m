Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUKCK3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUKCK3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbUKCK3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:29:49 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:50701 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261501AbUKCK3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:29:48 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       vlobanov <vlobanov@speakeasy.net>
Subject: Re: [TRIVIAL PATCH] /init/version.c
Date: Wed, 3 Nov 2004 12:29:31 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0411022359001.17128@shell2.speakeasy.net> <Pine.LNX.4.53.0411030929140.26206@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411030929140.26206@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031229.31412.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 10:29, Jan Engelhardt wrote:
> >Hi,
> >
> >After looking over the MAINTAINERS file, I have no idea who the right
> >point of contact / maintainer is for this code. (Or, I simply missed the
> >right entry while reading, which has been known to happen.) Please advise.
> 
> As stated in the MAINTAINERS file at the end, everything else goes to Linus.

However, I suspect it won't even compile.

See:
http://lxr.linux.no/source/init/main.c?v=2.6.8.1#L76
http://lxr.linux.no/source/fs/proc/proc_misc.c?v=2.6.8.1#L253
--
vda

