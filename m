Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVARVtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVARVtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 16:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVARVtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 16:49:53 -0500
Received: from gate.in-addr.de ([212.8.193.158]:7376 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261439AbVARVtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 16:49:50 -0500
Date: Tue, 18 Jan 2005 22:46:05 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: raid 1 - automatic 'repair' possible?
Message-ID: <20050118214605.GY22648@marowsky-bree.de>
References: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-01-18T22:18:01, "Kiniger, Karl (GE Healthcare)" <karl.kiniger@med.ge.com> wrote:

> idea for enhancement of software raid 1:
> 
> every time the raid determines that a sector cannot
> be read it could at least try to overwrite the bad are
> with good data from the other disk.

The idea is good and I'm sure we'll love to get a patch ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

