Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTL1Xyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbTL1Xyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:54:46 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:39072 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262288AbTL1Xyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:54:44 -0500
Date: Sun, 28 Dec 2003 15:54:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, wli@holomorphy.com
Subject: Re: [ANNOUNCE] 2.6.0-tiny1 tree for small systems
Message-ID: <20031228235417.GB1882@matchmail.com>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, wli@holomorphy.com
References: <20031227215606.GO18208@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227215606.GO18208@waste.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 03:56:06PM -0600, Matt Mackall wrote:
> This is the second release of the -tiny kernel tree. The aim of this
> tree is to collect patches that reduce kernel disk and memory
> footprint as well as tools for working on small systems. Target users
> are things like embedded systems, small or legacy desktop folks, and
> handhelds.
> 
> Latest release includes:
>  - "make checkstack" to find largest stack users

Maybe wli will be interested in this one since he has some stack shrinking
patches in his tree...
