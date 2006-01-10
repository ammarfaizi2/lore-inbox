Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWAJURu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWAJURu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWAJURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:17:50 -0500
Received: from quechua.inka.de ([193.197.184.2]:45737 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932325AbWAJURt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:17:49 -0500
Date: Tue, 10 Jan 2006 21:17:47 +0100
From: Bernd Eckenfels <be-mail2006@lina.inka.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2G memory split
Message-ID: <20060110201747.GA26433@lina.inka.de>
References: <43C3E9C2.1000309@rtr.ca> <E1EwNc8-00063F-00@calista.inka.de> <20060110194200.GD3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110194200.GD3389@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 08:42:00PM +0100, Jens Axboe wrote:
> Hmm I thought it was obvious with the description in paranthesis after
> the option. Basically the option is just an optimized default for 1GB of
> RAM, like the 2G option is tailored for 2GB of low mem on a 2GB machine.

The description was (for full 1Gb Low Memory) and not (optimized for 1GB
physical RAM) which would be more obvious, yes. However the text could still
explain the consequences.

Gruss
Bernd
