Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbUCPXul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUCPXul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:50:41 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:9876 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261848AbUCPXuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:50:40 -0500
Date: Tue, 16 Mar 2004 23:50:10 +0000
From: Dave Jones <davej@redhat.com>
To: David Erickson <david.erickson@intransa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT3 FS Assertion failure in journal_forget_R50b6d8df() at transaction.c:1259
Message-ID: <20040316235010.GA26872@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Erickson <david.erickson@intransa.com>,
	linux-kernel@vger.kernel.org
References: <68C08EF22187944DAF11634CB353DB6804DD0C@E2K3-CLUS-01.intransa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68C08EF22187944DAF11634CB353DB6804DD0C@E2K3-CLUS-01.intransa.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 03:41:10PM -0800, David Erickson wrote:

 > Running Redhat kernel 2.4.22-1.2115.nptl, I see the following for ext3
 > filesystems (iSCSI) on the initial mount after installing this kernel:

1. Wrong place. Red Hat bugs go into http://bugzilla.redhat.com

2. 2115 is ancient. Get the latest errata kernel.

		Dave

