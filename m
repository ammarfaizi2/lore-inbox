Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVCMBFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCMBFP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 20:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVCMBFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 20:05:15 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:47596 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261246AbVCMBFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 20:05:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=rCfe2lKQohDHBMZzxf+ToSslUmkGb/4DkbGnf6KDwED6cXu7Vf8w9DDpW3383WGFoFqRpwko1CaUyLhhdlBIzxexagObNl31dGz/AnBWwELmMhQJBZMYzghE9aK/t809n09F54O1uDIH6HkuaPqsQFgBl8q6haEenBOC2W6MXGM=
Message-ID: <17d798805031217055a3e9cc6@mail.gmail.com>
Date: Sat, 12 Mar 2005 20:05:11 -0500
From: firefly blue <fireflyblue@gmail.com>
Reply-To: firefly blue <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6 : physical memory address and pid
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the 2.6 Linux kernel, I want to find, from the physical page
frame, the virtual address of the page loaded in the frame and the
process id of the process owning it.

I know that 2.6 kernel implements rmap where the page points to a pte
chain. But how to I get to the pid and virtual address from pte entry?

I have tried to become a member of this list. But don't have a confirmation yet.
So, please cc the replies to me.

thanks,
Allison
