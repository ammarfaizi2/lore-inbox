Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbUJZOJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbUJZOJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbUJZOJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:09:50 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:33699 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262270AbUJZOJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:09:45 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Is anyone using the load_ramdisk= option in the kernel still?
In-Reply-To: <200410261603.30707.lists@b-open-solutions.it>
References: <clkheo$otl$1@terminus.zytor.com> <clkheo$otl$1@terminus.zytor.com> <200410261603.30707.lists@b-open-solutions.it>
Date: Tue, 26 Oct 2004 15:09:44 +0100
Message-Id: <E1CMS1A-0001F5-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Amici <lists@b-open-solutions.it> wrote:
> On Tuesday 26 October 2004 05:48, H. Peter Anvin wrote:
>> a) Does anyone use the load_ramdisk= option anymore, or is it
>> legitimate to drop?
> 
> I'm pretty sure it is used by the Debian installer when bootstrapping from a 
> floppy, but...

I believe that this is no longer the case with the new installer.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
