Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbULAOit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbULAOit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 09:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULAOis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 09:38:48 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:11027 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S261260AbULAOim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 09:38:42 -0500
Message-ID: <41ADF311.7030802@gentoo.org>
Date: Wed, 01 Dec 2004 16:36:33 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cd burning, capabilities and available modes
References: <1101908433l.8423l.0l@werewolf.able.es>
In-Reply-To: <1101908433l.8423l.0l@werewolf.able.es>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.9 (-----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CZVcs-000JuN-Jc*YbywlOWt0BA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

J.A. Magallon wrote:
> As user:
> werewolf:/store/tmp> cdrecord -dummy dev=ATAPI:1,0,0 *.iso
> ...

Try with the real device name, e.g. dev=/dev/hdc

Daniel
