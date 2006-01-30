Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWA3Tdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWA3Tdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWA3Tdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:33:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:39388 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964909AbWA3Tdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:33:52 -0500
Date: Mon, 30 Jan 2006 10:58:08 -0800
From: Greg KH <gregkh@suse.de>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@stusta.de>,
       Scott_Kilau@digi.com
Subject: Re: [RFC: linux-2.6.16-rc1 patch] jsm: fix for high baud rates problem
Message-ID: <20060130185808.GA17533@suse.de>
References: <43DE30F1.6040107@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DE30F1.6040107@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 09:29:53AM -0600, V. Ananda Krishnan wrote:
> Digi serial port console doesn't work when baud rates are set higher 
> than 38400.  So the lookup table and code in jsm_neo.c has been modified 
> and tested.  Please let me have the feed-back.
> 
> Thanks,
> V. Ananda Krishnan
> 
> 
> 
> Authors: Scott Kilau and V. Ananda Krishnan
> Signed-off-by: V.Ananda Krishnan

Wrong Signed-off-by: format :(

