Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVBCLx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVBCLx1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbVBCLx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:53:26 -0500
Received: from gate.firmix.at ([80.109.18.208]:28384 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S263602AbVBCLw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:52:27 -0500
Subject: Re: creating daemons
From: Bernd Petrovitsch <bernd@firmix.at>
To: root <muruganandam@softhome.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ctsvsg$kpg$3@sea.gmane.org>
References: <ctsvsg$kpg$3@sea.gmane.org>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1107431541.19076.12.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Thu, 03 Feb 2005 12:52:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 15:24 +0530, root wrote:
>   i want run my program as a daemon..its like normal
> how to do that
> service squid start

Look into /etc/init.d/squid (or wherever your distribution puts the
SysV-Init startup files) on how to write a similar script for your
daemon.
And BTW this has nothing to do with the Linux *kernel*.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

