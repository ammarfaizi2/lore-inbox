Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRKMTxg>; Tue, 13 Nov 2001 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRKMTx0>; Tue, 13 Nov 2001 14:53:26 -0500
Received: from bluebox.ne.mediaone.net ([24.128.139.92]:31248 "EHLO
	osiris.978.org") by vger.kernel.org with ESMTP id <S278653AbRKMTxP>;
	Tue, 13 Nov 2001 14:53:15 -0500
Date: Tue, 13 Nov 2001 14:53:15 -0500
From: Brian Ristuccia <bristucc@sw.starentnetworks.com>
To: linux-kernel@vger.kernel.org
Cc: bristucc@sw.starentnetworks.com
Subject: elvtune fails with DAC960 and devfs on 2.4.14
Message-ID: <20011113145315.T22467@osiris.978.org>
Mail-Followup-To: bristucc@sw.starentnetworks.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't seem to adjust the elevator parameters for this block device, but
can't:

# elvtune /dev/rd/disc0/disc
ioctl get: Invalid argument

Tried unsucessfully with elvtune from Debian's elvtune package 2.11l-3 and
also 2.11m from kernel.org.

Any hints?

-- 
Brian Ristuccia
bristucc@sw.starentnetworks.com
