Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVBFNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVBFNHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVBFNHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:07:17 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:55417 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261219AbVBFNFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:05:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AmdrSlWwpD5Pjwg2bSASvLNZOpkpY3/fJ+MXhN95cScr54GeFLV+Rdh5zxRDvAp1x6aFMTwmbr/LA1Gj2HuEvPvVXLWiAjY7f0ixCwDIGQCZ1n32coggu48/2knnDahhOOhi4Yj3FsaFvGBXa+ijKe93RiVL3CbVR8aS5QMXwsQ=
Message-ID: <58cb370e05020605052427549e@mail.gmail.com>
Date: Sun, 6 Feb 2005 14:05:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 13/14] ide_pci: Removes unused SVWKS_DEBUG_DRIVE_INFO
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050204071319.7C6FA13264B@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42032014.1020606@home-tj.org>
	 <20050204071319.7C6FA13264B@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2005 16:13:19 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 13_ide_pci_serverworks_cleanup.patch
> 
>         Removes unused SVWKS_DEBUG_DRIVE_INFO from ide/pci/serverworks
>         driver.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
