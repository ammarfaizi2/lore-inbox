Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUANUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266338AbUANUBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:01:41 -0500
Received: from lech.pse.pl ([194.92.3.7]:64426 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id S266336AbUANUBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:01:18 -0500
Date: Wed, 14 Jan 2004 21:01:13 +0100
From: Lech Szychowski <lech.szychowski@pse.pl>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Catch 22
Message-ID: <20040114200113.GA7237@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	linux-kernel@vger.kernel.org
References: <400554C3.4060600@sms.ed.ac.uk> <20040114090137.5586a08c.jkl@sarvega.com> <20040114091456.752ad02d.rddunlap@osdl.org> <40058DAB.30802@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40058DAB.30802@grupopie.com>
Organization: Polskie Sieci Elektroenergetyczne S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - mount /dev/hda somewhere (/mnt/disk or something)
>  - # cd /mnt/disk
>  - edit etc/lilo.conf to always use /dev/hda
>  - # chroot . lilo

AFAIR "lilo -r /mnt/disk" would be a better/easier way to
achieve the same result you're trying to get with the last line.

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
