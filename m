Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVDNI1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVDNI1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVDNI1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:27:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:748 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261463AbVDNI1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:27:48 -0400
Date: Thu, 14 Apr 2005 10:27:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414082731.GB1360@elf.ucw.cz>
References: <20050413233904.GA31174@gondor.apana.org.au> <E1DLsvN-0008VO-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1DLsvN-0008VO-00@calista.eckenfels.6bone.ka-ip.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 14-04-05 03:13:41, Bernd Eckenfels wrote:
> In article <20050413233904.GA31174@gondor.apana.org.au> you wrote:
> > The dmcrypt swap can only be unlocked by the user with a passphrase,
> > which is analogous to how you unlock your ssh private key stored
> > on the disk using a passphrase.
> 
> We talk about the unlocked system getting hacked. However I am not why the
> hacker would head for the swap if he can as well read the ram.

Various openssl-s, ssh-s and others are pretty carefull to wipe their
RAM when it is no longer neccessary.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
