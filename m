Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUBDR4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUBDR4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:56:37 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:58796 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261368AbUBDR4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:56:36 -0500
Date: Wed, 4 Feb 2004 18:56:33 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.2 aka "Feisty Dunnart"
Message-ID: <20040204175633.GA22679@louise.pinerecords.com>
References: <40210578.6000504@mrc-bsu.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40210578.6000504@mrc-bsu.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb-04 2004, Wed, 14:45 +0000
Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk> wrote:

> 2.6 is looking great from here, no visible problems for me.

Try "du -k ." on a loop-mounted minix filesystem.
That's what I found today. ;)

-- 
Tomas Szepe <szepe@pinerecords.com>
