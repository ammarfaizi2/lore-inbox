Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVAJJeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVAJJeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVAJJeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:34:15 -0500
Received: from gate.firmix.at ([80.109.18.208]:56750 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S262174AbVAJJeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:34:06 -0500
Subject: Re: printk output to file
From: Bernd Petrovitsch <bernd@firmix.at>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050110082633.4796.qmail@web60605.mail.yahoo.com>
References: <20050110082633.4796.qmail@web60605.mail.yahoo.com>
Content-Type: text/plain
Organization: http://www.firmix.at/
Date: Mon, 10 Jan 2005 10:34:03 +0100
Message-Id: <1105349643.8226.5.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 00:26 -0800, selvakumar nagendran wrote:
>     I want to redirect the output of printk from my
> kernel module to a file. If that's possible how can I
> do that? 

You have to configure syslog correctly. Again this has nothing to do
with the kernel.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



