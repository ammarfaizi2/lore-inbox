Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUBUAct (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUBUAcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:32:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:32490 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261452AbUBUAcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:32:39 -0500
X-Authenticated: #21910825
Message-ID: <4036A6F2.60907@gmx.net>
Date: Sat, 21 Feb 2004 01:31:46 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jari Ruusu <jariruusu@users.sourceforge.net>
CC: James Morris <jmorris@redhat.com>, Jean-Luc Cooke <jlcooke@certainkey.com>,
       Christophe Saout <christophe@saout.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
References: <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari,

since mainline cryptoloop/dm-crypt implementation is being changed right
now and you were complaining about it in the past, can you participate in
the discussions (there's also a parallel thread titled "[PATCH/proposal]
dm-crypt: add digest-based iv generation mode") so you don't have to
complain afterwards?

James Morris wrote:
> On Fri, 20 Feb 2004, Jean-Luc Cooke wrote:
> 
> 
>>If others on the list care to do this, I'll give recommendation on how to 
>>implement the security (hmac, salt, iteration counts, etc).  But I think
>>this may break backward compatibility.  Can anyone speak to this?
> 
> 
> Please focus your recommendations on security, not backward compatibility
> with something that is new to the kernel tree, broken and maintainerless.


Thanks,
Carl-Daniel

