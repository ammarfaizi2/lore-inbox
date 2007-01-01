Return-Path: <linux-kernel-owner+w=401wt.eu-S932926AbXAAHYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbXAAHYH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 02:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbXAAHYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 02:24:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:3482 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbXAAHYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 02:24:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:reply-to:to:subject:date:user-agent:references:in-reply-to:disposition-notification-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HHp9OaUzM/XhFwwSfPI4kyjlHHKW8A2BUbecDH+vgcAvYWBbQ0f90KC5a7wb4pTR5eZNmBRLzYkbKuqSczsJEmW2wOqdl2w/EibHyVE/TNMuqKcFaG/vTu/lD73RVBhq4W3N6//BnogYcKWaaCvCwimBhow5u+BhjGCsaTLfrr0=
From: "Cyrill V. Gorcnov" <gorcunov@gmail.com>
Reply-To: gorcunov@gmail.com
To: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Date: Mon, 1 Jan 2007 10:22:54 +0300
User-Agent: KMail/1.9.5
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011022.54336.gorcunov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 January 2007 04:19, you wrote:
|  
|  In order to not get in trouble with MADR ("Mothers Against Drunk 
|  Releases") I decided to cut the 2.6.20-rc3 release early rather than wait 
|  for midnight, because it's bound to be new years _somewhere_ out there. So 
|  here's to a happy 2007 for everybody.
|  

I've tried to clone linux git repo and got:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
	fatal: unexpected EOF
	fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.

What's wrong?

Happy New Year ;)

-- 
	- Cyrill
