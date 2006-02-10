Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWBJQHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBJQHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBJQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:07:11 -0500
Received: from [81.2.110.250] ([81.2.110.250]:44969 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932136AbWBJQHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:07:08 -0500
Subject: Re: Let's get rid of  ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060210002148.37683.qmail@web50201.mail.yahoo.com>
References: <20060210002148.37683.qmail@web50201.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 16:09:41 +0000
Message-Id: <1139587781.12521.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-09 at 16:21 -0800, Alex Davis wrote:
> I think we should get rid of ide-scsi.
> 
> Reasons:
> 1) It's broken.
> 2) It's unmaintained.
> 3) It's unneeded.


#1 is half wrong
#2 is half wrong
#3 is totally wrong

There are devices such as multichangers that need it.

Please wait for the longer term cure - killing off drivers/ide 8).

Alan

