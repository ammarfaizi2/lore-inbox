Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVGVKTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVGVKTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 06:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVGVKSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 06:18:00 -0400
Received: from ns.firmix.at ([62.141.48.66]:12706 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261595AbVGVKR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 06:17:58 -0400
Subject: Re: 10 GB in Opteron machine
From: Bernd Petrovitsch <bernd@firmix.at>
To: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de>
References: <20050722105516.6ccffb8f.Christoph.Pleger@uni-dortmund.de>
	 <42E0B6E4.1030303@pobox.com>
	 <20050722113138.5d81c770.Christoph.Pleger@uni-dortmund.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Fri, 22 Jul 2005 12:17:38 +0200
Message-Id: <1122027458.14347.8.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 11:31 +0200, Christoph Pleger wrote:
[...]
> 2. All other software on the machine is 32-bit software. Will that
> software work with a 64-bit kernel?

Basically yes.
E.g. open-office does not exist natively for 64bit architectures ATM (at
least not on x86-compatibles).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

