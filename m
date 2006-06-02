Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWFBQLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWFBQLg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWFBQLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:11:36 -0400
Received: from vena.lwn.net ([206.168.112.25]:3310 "HELO lwn.net")
	by vger.kernel.org with SMTP id S932080AbWFBQLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:11:35 -0400
Message-ID: <20060602161135.8390.qmail@lwn.net>
To: "Nitin Jerath" <nitin.jerath@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netpoll/network drivers documentation or book 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 02 Jun 2006 19:36:57 +0530."
             <be9d6fff0606020706h692b5964y153ffa67157f336a@mail.gmail.com> 
Date: Fri, 02 Jun 2006 10:11:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wanted to know of a good source of documentation or book for netpoll
>  and Network Device drivers in general.

LDD3 (http://lwn.net/Kernel/LDD3/) has a chapter on network drivers,
with a (quite) brief section on netpoll.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
