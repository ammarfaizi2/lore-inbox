Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWCFQRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWCFQRy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWCFQRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:17:54 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:29834 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751137AbWCFQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:17:53 -0500
Date: Mon, 6 Mar 2006 17:17:50 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, heiko.carstens@de.ibm.com,
       schwidefsky@de.ibm.com
Subject: Re: + s390-add-modalias-to-uevent-for-ccw-devices.patch added to
 -mm tree
Message-ID: <20060306171750.013f011a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060306160234.GF19703@wavehammer.waldi.eu.org>
References: <200603060714.k267E6gN021778@shell0.pdx.osdl.net>
	<20060306110416.1e14933f@gondolin.boeblingen.de.ibm.com>
	<20060306135017.GA18874@wavehammer.waldi.eu.org>
	<20060306163950.5eb027e6@gondolin.boeblingen.de.ibm.com>
	<20060306160234.GF19703@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2006 17:02:34 +0100
Bastian Blank <bastian@waldi.eu.org> wrote:

> This will get fixed in my next patch, which uses add_uevent_var where
> possible.

Sounds good - thanks for working on this!

Cornelia
