Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVKMAmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVKMAmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 19:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVKMAmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 19:42:08 -0500
Received: from gate.in-addr.de ([212.8.193.158]:46546 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S964898AbVKMAmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 19:42:08 -0500
Date: Sun, 13 Nov 2005 01:41:28 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: inode kernel option for HA clustering/rsync
Message-ID: <20051113004128.GR2491@marowsky-bree.de>
References: <BAY103-F135A769ABB42E29158E0DBAA580@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAY103-F135A769ABB42E29158E0DBAA580@phx.gbl>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-11-12T04:38:42, Matt Hersant <mhearse@hotmail.com> wrote:

> I'm working on a clustering project which utilizes rsync for system 
> mirroring.  A main priority is to reduce rsync runtime and IO load.  I have 
> heard of a kernel 'inode' option which can be used to cache a list of 
> modified files.  The list of files is then passed to rsync on the next run. 
> Has anyone heard of this kernel option.  Thanks in advance.

google:inotify


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

