Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUFWOB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUFWOB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265197AbUFWOB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:01:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:34766 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265196AbUFWOB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:01:26 -0400
Date: Wed, 23 Jun 2004 16:01:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: tom st denis <tomstdenis@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c comments
Message-ID: <20040623140126.GB32410@wohnheim.fh-wedel.de>
References: <20040623133309.43964.qmail@web41101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040623133309.43964.qmail@web41101.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 June 2004 06:33:09 -0700, tom st denis wrote:
> 
> I was toying around with the idea of making /proc/meminfo use KiB as
> the unit instead of KB 

Not an option.  The layout of files in /proc/ is effectively a user
interface.  Any change can break any program.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
