Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbUL3Vvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbUL3Vvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 16:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUL3Vvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 16:51:49 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:18198 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261720AbUL3Vvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 16:51:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bSbmcCEirNuRP7HcG1IyD7uuH3VKtpUj0VOJyXgk4TabsLdsi+GhMhiRQ0EbG0AweRkdMK40kpoWnwy8ueD2iMlZS6faLPGz4C3+zKwnkRiXcawQ9NDJ/UHnZwI2pWjdSY4BAGBGZApr4HSAaksQcbVPEqux7pwAQwZwZzkxQBY=
Message-ID: <58cb370e041230135065254660@mail.gmail.com>
Date: Thu, 30 Dec 2004 22:50:48 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: 2.6.10 - Add support for CSB6 RAID
Cc: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1104156116.20898.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1104156116.20898.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 14:01:56 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> The serverworks chips include a raid variant that the 2.6 driver didn't
> support. This enables support for this and removes a pile of #if and
> other pointless obfuscations. This removes the need to use various
> vendor binary only drivers for CSB6 RAID

applied
