Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287630AbSAPVNc>; Wed, 16 Jan 2002 16:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287627AbSAPVMP>; Wed, 16 Jan 2002 16:12:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:28939 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287630AbSAPVLg>; Wed, 16 Jan 2002 16:11:36 -0500
Date: Wed, 16 Jan 2002 17:58:49 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compaq PCI Hotplug driver bugfix
In-Reply-To: <20020116205938.GA2604@kroah.com>
Message-ID: <Pine.LNX.4.21.0201161758440.28001-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied.

On Wed, 16 Jan 2002, Greg KH wrote:

> Hi,
> 
> Here's a patch against 2.4.18-pre4 for the Compaq PCI Hotplug driver
> that fixes two memory leaks in the driver (one if registering a slot
> fails, and the other when the driver is unloaded from the kernel.)

