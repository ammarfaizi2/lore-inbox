Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUGBRMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUGBRMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 13:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUGBRMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 13:12:55 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:19462 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264656AbUGBRMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 13:12:40 -0400
Date: Fri, 2 Jul 2004 19:12:38 +0200
From: Andries Brouwer <aebr@wsdw14.win.tue.nl>
To: Ferry van Steen <freaky@bananateam.nl>
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: USB Memory Stick issues (After using it in Wyse Terminal (WindowsCE.NET))
Message-ID: <20040702171238.GA6456@pclin040.win.tue.nl>
References: <Pine.LNX.4.33.0407021541270.30945-100000@www.bananateam.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0407021541270.30945-100000@www.bananateam.nl>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 03:49:04PM +0200, Ferry van Steen wrote:

> the patch Andries Brouwer gave me seems to work. That is, I can mount the
> USB stick like:
> 
> mount /dev/sda /mnt/usbstick -t vfat

Good. Thanks!

> fdisk -l /dev/sda will still not see any partitions however

There are none.

(This is just a whole-disk FAT filesystem.)

Andries
