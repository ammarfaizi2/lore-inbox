Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUFWORJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUFWORJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUFWORJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:17:09 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:9863 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S265203AbUFWORB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:17:01 -0400
Mail-Followup-To: jgarzik@pobox.com,
  linux-kernel@vger.kernel.org
MBOX-Line: From george@galis.org  Wed Jun 23 10:16:59 2004
Date: Wed, 23 Jun 2004 10:16:59 -0400
From: George Georgalis <george@galis.org>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: SIIMAGE sata fails with 2.6.7
Message-ID: <20040623141659.GD30929@trot.local>
References: <20040622170557.GA16617@trot.local> <40D895C6.3070306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D895C6.3070306@pobox.com>
X-Time: trot.local; @636; Wed, 23 Jun 2004 10:16:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:25:42PM -0400, Jeff Garzik wrote:
>does sata_sil driver work for you?

I have this file,

-rw-r--r--    1 500      500         12779 Jun 16 01:18 ./drivers/scsi/sata_sil.c

but I don't see a switch for it in the config, also I'm not sure where
the most recent patch for it is.

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

