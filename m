Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272450AbTHMMVs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272454AbTHMMVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:21:48 -0400
Received: from gate.firmix.at ([80.109.18.208]:19122 "EHLO tara.firmix.at")
	by vger.kernel.org with ESMTP id S272450AbTHMMVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:21:47 -0400
Subject: Re: vsnprintf patch
From: Bernd Petrovitsch <bernd@firmix.at>
To: Adrian Reber <adrian@lisas.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030813115212.GA28066@lisas.de>
References: <20030813115212.GA28066@lisas.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060777304.11598.14.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Aug 2003 14:21:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 2003-08-13 at 13:52, Adrian Reber wrote:
> When using the snprintf function from the kernel the length returned is
> not the length written:

This is how the function is defined:
http://www.opengroup.org/onlinepubs/007908799/xsh/fprintf.html

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services
