Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUF1Byy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUF1Byy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 21:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUF1Byk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 21:54:40 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:8345 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S264637AbUF1Byc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 21:54:32 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org,
  jfbeam@bluetronic.net
MBOX-Line: From george@galis.org  Sun Jun 27 21:54:31 2004
Date: Sun, 27 Jun 2004 21:54:31 -0400
From: George Georgalis <george@galis.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sata_sil quirk
Message-ID: <20040628015431.GA31687@trot.local>
References: <40D8FE55.3030008@pobox.com> <Pine.GSO.4.33.0406230230010.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406230230010.25702-100000@sweetums.bluetronic.net>
X-Time: trot.local; @121; Sun, 27 Jun 2004 21:54:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 02:34:35AM -0400, Ricky Beam wrote:
>
>That list needs a:
>         { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
>as well.

happens to be my drive, is there any way to tell a drive needs
be in the quirk 15 list, other than it's Seagate and big writes
block the dev? 

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

