Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261921AbVBIVoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVBIVoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 16:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVBIVoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 16:44:18 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:55049 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S261921AbVBIVoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 16:44:11 -0500
Message-ID: <35297.194.237.142.7.1107985448.squirrel@194.237.142.7>
In-Reply-To: <4209C71F.9040102@web.de>
References: <4209C71F.9040102@web.de>
Date: Wed, 9 Feb 2005 22:44:08 +0100 (CET)
Subject: Re: How to retrieve version from kernel source (the right way)?
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Michael Renzmann" <mrenzmann@web.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But... what is the right way to do this?

I think you are looking for:
make kernelrelease

   Sam

