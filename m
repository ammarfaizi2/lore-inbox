Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbUC1UXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUC1UW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:22:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262442AbUC1UWt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:22:49 -0500
Message-ID: <4067340A.5080709@pobox.com>
Date: Sun, 28 Mar 2004 15:22:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Ryan Earl" <heretic@clanhk.org>
CC: Stefan Smietanowski <stesmi@stesmi.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Status of the sata_sil driver for the VT8237
References: <4066342B.4080105@clanhk.org> <406643A8.2050808@pobox.com> <40664AE4.8010003@clanhk.org> <406680AB.8090204@stesmi.com> <4066833B.4080004@clanhk.org>
In-Reply-To: <4066833B.4080004@clanhk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Ryan Earl wrote:
> Stefan Smietanowski wrote:
> 
>> Many A64 boards today come with a Promise SATA controller as well -
>> works like a charm for me on an ASUS K8V Deluxe board here.
> 
> 
> That's an option, as is just using the sii3112 that's been working so 
> well, but that still puts the disks on the PCI bus.  The whole point is 
> to get 300MB/sec of burstable I/O off the 133MB/s bus that's shared with 
> the dual gigE controllers and a firewire camera.


Do you really plan to get 300MB/sec from two disks?  :)

	Jeff



