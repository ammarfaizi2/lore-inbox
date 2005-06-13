Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVFMMHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFMMHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVFMMHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:07:37 -0400
Received: from gs.bofh.at ([193.154.150.68]:20944 "EHLO gs.bofh.at")
	by vger.kernel.org with ESMTP id S261520AbVFMMF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:05:57 -0400
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Bernd Petrovitsch <bernd@firmix.at>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f192987705061303383f77c10c@mail.gmail.com>
References: <f192987705061303383f77c10c@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 13 Jun 2005 14:05:52 +0200
Message-Id: <1118664352.898.16.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 14:38 +0400, Alexey Zaytsev wrote:
[ Filenames with another encoding ]
> Some would suggest not to use non-ascii file names at all, some would
> say that I should temporary change my locale, some could even offer me
> a perl script they wrote when faced the same problem. All these
> solutions are inconvenient and conflict with fundamental VFS concepts.
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In what way?
Basically you just rename the files. How can this conflict with
"fundamental VFS concepts" (and with which).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

