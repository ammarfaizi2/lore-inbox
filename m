Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263718AbTDITOC (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263719AbTDITOC (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:14:02 -0400
Received: from fmr02.intel.com ([192.55.52.25]:1763 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263718AbTDITOB convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:14:01 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780BEBA42E@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'oliver@neukum.name'" <oliver@neukum.name>,
       "'Matti Aarnio'" <matti.aarnio@zmailer.org>,
       "'Frank Davis'" <fdavis@si.rr.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-english user messages
Date: Wed, 9 Apr 2003 12:25:36 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Oliver Neukum 

> If we do this, why not go the whole way?
> Could we compute a hash value for every message that's not KERN_CRIT,
> use it to create a table of messages and hashes and replace the messages
> in the kernel image with the hash values leaving expansion to klogd?

What about argument expansion? You are killing it

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

