Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWEMPic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWEMPic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 11:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWEMPic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 11:38:32 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:24993 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751314AbWEMPib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 11:38:31 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Linux 2.6.16.16
Date: Sat, 13 May 2006 17:35:19 +0200
User-Agent: KMail/1.9.1
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv> <20060511173312.GI25010@moss.sous-sol.org>
In-Reply-To: <20060511173312.GI25010@moss.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605131735.20062.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

first of all: Thanks for the good work!

On Thursday, 11. May 2006 19:33, Chris Wright wrote:
> Assigning any official severity is a bit of a slippery slope, but
> making sure it's clear what type of issue (i.e. local DoS in this case)
> is very reasonable.

Yes, I agree.

I would like to know:
- local or remote exploitable
- if a DoS: hang, only service failure, major slowdown 
- privilege escalation possiible and how far (valid user, root, kernel-level)
- required privileges (root or user)

That would help risk management a lot :-)

If you have a lot of time: Affected software components, but these can
be taken from the patches/commit info or CVE.

Thanks & Regards

Ingo Oeser
