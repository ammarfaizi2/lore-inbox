Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbTHLQYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270810AbTHLQYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:24:48 -0400
Received: from gate.firmix.at ([80.109.18.208]:33201 "EHLO tara.firmix.at")
	by vger.kernel.org with ESMTP id S270766AbTHLQYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:24:47 -0400
Subject: Re: generic strncpy - off-by-one error
From: Bernd Petrovitsch <bernd@firmix.at>
To: Anthony Truong <Anthony.Truong@mascorp.com>
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1060651689.10867.23.camel@huykhoi>
References: <1060651689.10867.23.camel@huykhoi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060705476.9950.4.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 12 Aug 2003 18:24:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't see any problem with this code, and if we don't need to
>NULL-pad the dest string, we do not have to.  It is not in the
>definition of strncpy(). 

Wrong: http://www.opengroup.org/onlinepubs/007908799/xsh/strncpy.html

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services
