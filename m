Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTKFP6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTKFP6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:58:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263667AbTKFP6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:58:17 -0500
Date: Thu, 6 Nov 2003 15:58:15 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marcel Lanz <marcel.lanz@ds9.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: load 2.4.x binary only module on 2.6
Message-ID: <20031106155815.GQ7665@parcelfarce.linux.theplanet.co.uk>
References: <20031106153004.GA30008@ds9.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106153004.GA30008@ds9.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 04:30:04PM +0100, Marcel Lanz wrote:
> I have a binary only module for 2.4.x.
> How much work is it to write a kind of wrapper to load an "old" module
> on 2.6 ?

Unfeasible.
