Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTDQAFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTDQAFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:05:43 -0400
Received: from fmr06.intel.com ([134.134.136.7]:6390 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261962AbTDQAFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:05:42 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C262E0E@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'ranty@debian.org'" <ranty@debian.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: firmware separation filesystem (fwfs)
Date: Wed, 16 Apr 2003 17:17:25 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: David Gibson [mailto:david@gibson.dropbear.id.au]
>
> My personal feeling is that this would probably make more sense as a
> type of sysfs node, rather than a separate filesystem, but the basic
> concept seems sound.

Would not the new binary interface to sysfs help to sort 
this out?

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
