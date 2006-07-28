Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWG1Psj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWG1Psj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWG1Psj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:48:39 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:64677 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1752021AbWG1Psi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:48:38 -0400
Message-ID: <44CA31D2.70203@slaphack.com>
Date: Fri, 28 Jul 2006 10:48:34 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
CC: Jeff Garzik <jeff@garzik.org>, Hans Reiser <reiser@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
In-Reply-To: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand wrote:
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> [...]
> 
>> It is then simple to follow that train of logic:  why not make it easy
>> to replace the directory algorithm [and associated metadata]?  or the
>> file data space management algorithms?  or even the inode handling?
>> why not allow customers to replace a stock algorithm with an exotic,
>> site-specific one?
> 
> IMVHO, such experiments should/must be done in userspace. And AFAICS, they
> can today.

inode handling?  Really?

But what's wrong with people doing such experiments outside the kernel? 
  AFAICS, "exotic, site-specific one" is not something that would be 
considered for inclusion.
