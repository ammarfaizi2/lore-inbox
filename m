Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWGMGnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWGMGnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGMGnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:43:33 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:46001 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964836AbWGMGnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:43:33 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/2] add function documentation for register_chrdev()
Date: Thu, 13 Jul 2006 08:49:42 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200607120942.23071@bilbo.math.uni-mannheim.de> <200607120946.16501@bilbo.math.uni-mannheim.de> <20060712085319.0ae7b346.rdunlap@xenotime.net>
In-Reply-To: <20060712085319.0ae7b346.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130849.42481@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
>On Wed, 12 Jul 2006 09:46:16 +0200 Rolf Eike Beer wrote:
>> Documentation for register_chrdev() was missing completely.
>
>I noticed that too.
>
>Would you modify the patch to use the kernel-doc format, please?

Eeks, damn. Sorry, it was meant to be this way.

>and "-ve" is overused/overrated. :)  Please use "negative".
>(even though Andrew just used -ve yesterday)

Just copied that from some other function in that file :)

Will resend soon.

Eike
