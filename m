Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUDGOwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUDGOwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:52:30 -0400
Received: from gate.in-addr.de ([212.8.193.158]:55219 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S263705AbUDGOvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:51:41 -0400
Date: Wed, 7 Apr 2004 16:51:26 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Gewj <geweijin@sinosoft.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: A puzzling thing about RAID5: syslogd write the log success but another process can not read the /var/log/messages
Message-ID: <20040407145126.GA23517@marowsky-bree.de>
References: <407400F1.8090809@sinosoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <407400F1.8090809@sinosoft.com.cn>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-04-07T21:24:01,
   Gewj <geweijin@sinosoft.com.cn> said:

> hammm,tonight is funny because I got a puzzling thing just as....
> 
> my setup is a two-scsi-disk raid5 configuration...

Impossible. RAID5 requires at least three disks.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

