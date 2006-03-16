Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWCPUMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWCPUMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbWCPUMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:12:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13481 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932712AbWCPUMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:12:07 -0500
Date: Thu, 16 Mar 2006 21:11:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Schwab <schwab@suse.de>
cc: Stefan Seyfried <seife@suse.de>, Denis Vlasenko <vda@ilport.com.ua>,
       linux-kernel@vger.kernel.org, christiand59@web.de
Subject: Re: /dev/stderr gets unlinked 8]
In-Reply-To: <jehd5zq28o.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0603162111400.11776@yvahk01.tjqt.qr>
References: <200603141213.00077.vda@ilport.com.ua> <200603141411.11121.christiand59@web.de>
 <200603141535.57978.vda@ilport.com.ua> <20060315110252.GB31317@suse.de>
 <jehd5zq28o.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> any good daemon closes stdout, stderr, stdin
>
>A real good daemon would redirect them to /dev/null.
>
and writes to /var/log/mysql/...


Jan Engelhardt
-- 
