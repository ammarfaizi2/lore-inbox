Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbUA0Qdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbUA0Qdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:33:51 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:60554 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265632AbUA0Qds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:33:48 -0500
Message-ID: <401692E2.7010800@backtobasicsmgmt.com>
Date: Tue, 27 Jan 2004 09:33:38 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: GPL license and linux kernel modifications
References: <E1AlW2F-000N9k-00.bansh21-mail-ru@f13.mail.ru>
In-Reply-To: <E1AlW2F-000N9k-00.bansh21-mail-ru@f13.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bansh wrote:

> special exception, the source code distributed need not include
> anything that is normally distributed (in either source or binary
> form) with the major components (compiler, kernel, and so on) of the
> operating system on which the executable runs, unless that component
> itself accompanies the executable.
> ----------- cut COPYING -----------
> 
> It gives the possibility to not distribute compiler and other preprocessing tools.
> It looks like one can make a preprocessor or even one's own compiler (with one's syntax) which will be used for kernel building. But it's not required to distribute this compiler. So I can distribute linux kernel source code modified this way but no one will be able to build it. Is it ok?

Only if those "compiler and other preprocessing tools" are normally 
distributed with the O/S the executable runs on. If you create your own 
compiler, and it's not "normally distributed", then you can't publish 
source code in that language under the GPL without making the compiler 
available as well.

