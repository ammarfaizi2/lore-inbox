Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTFDWqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbTFDWqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:46:20 -0400
Received: from fmr05.intel.com ([134.134.136.6]:37088 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264262AbTFDWqT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:46:19 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780D6F1000@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Russell King'" <rmk@arm.linux.org.uk>,
       "'John Appleby'" <john@dnsworld.co.uk>
Cc: "'John Appleby'" <johna@unickz.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Serio keyboard issues 2.5.70
Date: Wed, 4 Jun 2003 15:59:44 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Russell King [mailto:rmk@arm.linux.org.uk]
>
> - serio device drivers (the things which drive the hardware) using
>   serio_register_port()
> - serio protocol drivers (the things which interpret the bytes,
>   like atkbd.c) using serio_register_device()

Kind of counter-intuitive :] I guess renaming to something
that is more obvious is out of the question at this page of
the book, right? Not that it is a big deal, though...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
