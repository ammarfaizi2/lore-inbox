Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267746AbSLGLJW>; Sat, 7 Dec 2002 06:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267747AbSLGLJW>; Sat, 7 Dec 2002 06:09:22 -0500
Received: from www.wotug.org ([194.106.52.201]:35393 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id <S267746AbSLGLJV>; Sat, 7 Dec 2002 06:09:21 -0500
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
To: Nathaniel Russell <root@chartermi.net>, reddog83@chartermi.net
Subject: Re: [PATCH 2.5.x] Via AGP Support
Date: Sat, 7 Dec 2002 10:55:17 +0000
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, <davej@suse.de>
References: <Pine.LNX.4.44.0212070538190.1642-200000@reddog.example.net>
In-Reply-To: <Pine.LNX.4.44.0212070538190.1642-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212071055.17560.ruth@ivimey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 December 2002 10:41, Nathaniel Russell wrote:
> This patch add's support for the Via 8633 AGP Card Slot.

> +               .device_id      = PCI_DEVICE_ID_VIA_8633_0,
> +               .vendor_id      = PCI_VENDOR_ID_VIA,
> +               .chipset        = VIA_GENRIC,

Missing 'E' in Generic ^^^

Ruth

-- 
Ruth Ivimey-Cook
Software Engineer and Technical Author.
