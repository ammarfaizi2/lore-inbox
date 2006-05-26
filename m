Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWEZFsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWEZFsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWEZFsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 01:48:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:7123 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030479AbWEZFsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 01:48:24 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [USB disks] FAT: invalid media value (0x01)
Date: Thu, 25 May 2006 22:48:18 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e564r2$84j$1@terminus.zytor.com>
References: <200605260029_MC3-1-C0CF-C67B@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148622498 8340 127.0.0.1 (26 May 2006 05:48:18 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 26 May 2006 05:48:18 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200605260029_MC3-1-C0CF-C67B@compuserve.com>
By author:    Chuck Ebbert <76306.1226@compuserve.com>
In newsgroup: linux.dev.kernel
> 
> > sdc: assuming drive cache: write through
> >  sdc: sdc1
> > sd 11:0:0:0: Attached scsi removable disk sdc
> > usb-storage: device scan complete
> > FAT: invalid media value (0x01)
> > VFS: Can't find a valid FAT filesystem on dev sdc.
>                                                 ^^^
> 
> Shouldn't it be looking on sdc1 for the filesystem?
> 

Well, it depends what "it" is...

	-hpa (whoa... haven't seen a CompuServe addy for ages...)
