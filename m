Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVCXQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVCXQnr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVCXQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:43:47 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:43736 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262639AbVCXQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:43:44 -0500
Date: Thu, 24 Mar 2005 11:43:13 -0500
To: Asfand Yar Qazi <ay1204@qazi.f2s.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: How's the nforce4 support in Linux?
Message-ID: <20050324164313.GL17865@csclub.uwaterloo.ca>
References: <3Lxis-5a0-29@gated-at.bofh.it> <3Lxis-5a0-31@gated-at.bofh.it> <3Lxis-5a0-33@gated-at.bofh.it> <3Lxis-5a0-27@gated-at.bofh.it> <3LxBD-5wd-9@gated-at.bofh.it> <4242975F.1030203@qazi.f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4242975F.1030203@qazi.f2s.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 10:33:03AM +0000, Asfand Yar Qazi wrote:
> No, but I do need NCQ

Perhaps a stupid question... but: Why do you _need_ NCQ?  If you need it
that badly (not sure why anyone would), you could always get SCSI or a
3ware controller.

NCQ is a nice feature, but hardly essential.

Len Sorensen
