Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966841AbWKTWEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966841AbWKTWEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbWKTWEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:04:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:8169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966831AbWKTWEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:04:32 -0500
Date: Mon, 20 Nov 2006 14:01:15 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       jejb@steeleye.com
Subject: Re: [RFC: 2.6 patch] remove the broken SKMC driver
Message-ID: <20061120140115.4cdec66a@freekitty>
In-Reply-To: <20061120210648.GB31879@stusta.de>
References: <20061120210648.GB31879@stusta.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any working microchannel drivers?  Can we drop support for microchannel
at the bus level?
