Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbULTVbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbULTVbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbULTVbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:31:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:37275 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261653AbULTVa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:30:59 -0500
Subject: Re: Basic UB q
From: Lee Revell <rlrevell@joe-job.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412202226100.8722@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0412202226100.8722@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 16:30:57 -0500
Message-Id: <1103578257.1252.95.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 22:26 +0100, Jan Engelhardt wrote:
> Hello list,
> 
> 
> what is the "ub" driver good for? Doesnot USB over SCSI work well enough?
> 

Because that requires the SCSI layer which is overkill for very simple
devices.

Lee

