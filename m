Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVHDGG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVHDGG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVHDGGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:06:55 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:64263 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261847AbVHDGF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:05:59 -0400
To: will.dyson@gmail.com
CC: jirislaby@gmail.com, linux-kernel@vger.kernel.org
In-reply-to: <8e6f9472050803214250821160@mail.gmail.com> (message from Will
	Dyson on Thu, 4 Aug 2005 00:42:54 -0400)
Subject: Re: Obsolete files in 2.6 tree
References: <42DED9F3.4040300@gmail.com> <42F145ED.2060008@gmail.com> <8e6f9472050803214250821160@mail.gmail.com>
Message-Id: <E1E0YrP-0000rm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 04 Aug 2005 08:05:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, don't know about anyone else, but I certainly don't use it
> anymore. If anyone needs  a fully-functional befs driver, the easiest
> route to that would probably be getting Haiku's befs driver to compile
> in userland as a FUSE fs.

That has already been done:

  http://prdownloads.sourceforge.net/fuse/mountlo-i386-0.1.tar.gz

All is needed is a working FUSE installation, and the above binary, to
be able to mount any filesystem image/partition.

Miklos
