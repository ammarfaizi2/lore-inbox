Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265655AbUFVVZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUFVVZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUFVVZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:25:13 -0400
Received: from vena.lwn.net ([206.168.112.25]:15279 "HELO lwn.net")
	by vger.kernel.org with SMTP id S265163AbUFVVYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:24:04 -0400
Message-ID: <20040622212403.21346.qmail@lwn.net>
To: rahul b jain cs student <rbj2@oak.njit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff structure 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 22 Jun 2004 16:48:27 EDT."
             <Pine.GSO.4.58.0406221647570.10319@chrome.njit.edu> 
Date: Tue, 22 Jun 2004 15:24:03 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In this structure there are pointers called headroom, data, tailroom and
> end. Does anyone know what these are used for. Or can anyone point me to a
> good explanation for these fields.

There is a basic discussion in chapter 14 of Linux Device Drivers which
you can read online at http://www.xml.com/ldd/chapter/book/index.html.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
