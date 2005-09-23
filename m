Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVIWUKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVIWUKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVIWUKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:10:20 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:35076 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751200AbVIWUKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:10:19 -0400
Date: Fri, 23 Sep 2005 22:11:40 +0200
From: Jean Delvare <khali@linux-fr.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [GIT PATCH] SCSI bug fixes for 2.6.14-rc1
Message-Id: <20050923221140.38d639e3.khali@linux-fr.org>
In-Reply-To: <1127229590.5589.2.camel@mulgrave>
References: <1127229590.5589.2.camel@mulgrave>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

> James Bottomley:
>   o Fix thread termination for the SCSI error handle

This presumably fixed a problem I was having when reading faulty
CD-ROMs on SCSI drives since 2.6.14-rc1. Thanks!

-- 
Jean Delvare
