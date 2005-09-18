Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVIRKzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVIRKzz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIRKzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:55:55 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:64174 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751091AbVIRKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:55:54 -0400
Subject: Re: Why don't we separate menuconfig from the kernel?
From: Ian Campbell <ijc@hellion.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Martin Fouts <Martin.Fouts@palmsource.com>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <m3zmqaek8c.fsf@defiant.localdomain>
References: <DE88BDF02F4319469812588C7950A97E93121E@ussunex1.palmsource.com>
	 <m3zmqaek8c.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Sun, 18 Sep 2005 11:55:49 +0100
Message-Id: <1127040949.3144.3.camel@insmouth>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-18 at 12:36 +0200, Krzysztof Halasa wrote:
> What I'm thinking of is moving menuconfig or *config out of the
> kernel so there is one well-defined external package.

If you really think it is worthwhile you could start maintaining a
package containing a copy of *config from the most recent kernel for all
these other projects to use, that would reduce the number of copies to
just 2, it would be a good start...

Ian.

-- 
Ian Campbell

Void where prohibited by law.

