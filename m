Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270424AbVBFBPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270424AbVBFBPj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270134AbVBFBPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:15:39 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:29380 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S272200AbVBFA6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:58:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ITC1bz6YEyeaxxJgfCmsoWOWirOEHoYgkPz92uO4WFpZNRGMyNpo+oR1/qTG/7IlNrA86kLqKaZ3CbUwjPviborAsfeoXPEsbbRgBxNiIeC5M1jzi/J6YlWIyT5PhEiORp9EE48y8+9ZL9b51D8tN8NfCcCH2CzJ6yLqxYJOGuI=
Message-ID: <58cb370e050205165846dee1ff@mail.gmail.com>
Date: Sun, 6 Feb 2005 01:58:03 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 05/14] ide_pci: Merges generic.h into generic.c
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071318.2F0EB132650@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071318.2F0EB132650@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:18 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 05_ide_pci_generic_merge.patch
> 
>         Merges ide/pci/generic.h into generic.c.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
