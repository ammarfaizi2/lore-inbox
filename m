Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTLJVrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTLJVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:47:52 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:22429 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263985AbTLJVrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:47:47 -0500
Date: Wed, 10 Dec 2003 13:47:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Accept ReiserFS Data Logging? was: Linux 2.4.24-pre1
Message-ID: <20031210214727.GA15401@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:23:14PM -0200, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes 2.4.24-pre1... 
> 
> The XFS filesystem has been merged.
> 
> This release contains mostly architecture specific updates.

Will you accept the data-logging patches for reiserfs3 from suse in this
release if it is submitted?

Don't forget that the OOM killer has been added as an option (defaulting to
off :)
