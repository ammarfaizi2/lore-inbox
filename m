Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVHEImN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVHEImN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVHEImM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:42:12 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:42508 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262913AbVHEImL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:42:11 -0400
To: will.dyson@gmail.com
CC: jirislaby@gmail.com, linux-kernel@vger.kernel.org
In-reply-to: <8e6f947205080411067f7a9e78@mail.gmail.com> (message from Will
	Dyson on Thu, 4 Aug 2005 14:06:16 -0400)
Subject: Re: Obsolete files in 2.6 tree
References: <42DED9F3.4040300@gmail.com> <42F145ED.2060008@gmail.com>
	 <8e6f9472050803214250821160@mail.gmail.com>
	 <E1E0YrP-0000rm-00@dorka.pomaz.szeredi.hu> <8e6f947205080411067f7a9e78@mail.gmail.com>
Message-Id: <E1E0xmB-0001gu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 05 Aug 2005 10:41:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you mis-understand. Mountlo seems to allow one to mount
> (through FUSE) any filesystem image for which there is a linux kernel
> kernel driver available. This is a very nice capability.
> 
> But what I speak of is to port the 100% feature-complete (and
> well-tested) befs driver from the Haiku project's kernel to the FUSE 
> interface. This should be a considerably easier task than porting it
> to the linux kernel vfs interface. Among other reasons for this, parts
> of Haiku's kernel (including their befs driver) are written in c++.

OK, thanks for the clarification.

Miklos
