Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTKYAwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTKYAwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:52:16 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:37382 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S261812AbTKYAwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:52:15 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200311250052.TAA16575@clem.clem-digital.net>
Subject: Re: final SCSI updates (hopefully) for 2.6.0
In-Reply-To: <1069716546.2870.69.camel@mulgrave> from James Bottomley at "Nov 24, 2003  5:29: 4 pm"
To: James.Bottomley@steeleye.com (James Bottomley)
Date: Mon, 24 Nov 2003 19:52:08 -0500 (EST)
Cc: torvalds@osdl.org, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Bottomley
  > This should be the final set of refcounting and bugfix updates.  It
  > contains the two refcounting fixes I identified earlier (now fully
  > tested) and a bugfix for the aic7xxx/aic79xx drivers which was caused by
  > one of the previous refcounting changes.
  > 
  > The patch is here
  > 
  > bk://linux-scsi.bkbits.net/scsi-bugfixes-2.6
  > 

FYI:
  Applied the patch set, cleared my hang on boot problem. Looks
  good now.

-- 
Pete Clements 
