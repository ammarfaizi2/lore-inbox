Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVAIB0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVAIB0j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVAIB0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:26:39 -0500
Received: from mproxy.gmail.com ([216.239.56.250]:43487 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262180AbVAIB02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:26:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lhDORSs1ETkKeK/OmvEfNez8xxhyL/fh5Nh16jq8XJoZvx8U46XyHq+G3ston7+Bv4xdHXsqFj5Kb+N8N3eJ/sX6G+HxVL5JvSClFgWbrkXl0mlq/bAv2go9ucFhAkh3jtW/9V/jxDgLa9hiuYOPkaldQN8ZPbkcH01fkGtSiII=
Message-ID: <21d7e9970501081726278f525a@mail.gmail.com>
Date: Sun, 9 Jan 2005 12:26:27 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Brice.Goglin@ens-lyon.org
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, Benoit Boissinot <bboissin@gmail.com>,
       Mike Werner <werner@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <41DE8AFB.9000305@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <41DE8AFB.9000305@ens-lyon.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Same *ERROR* here on my Compaq Evo N600c (Radeon Mobility M6 LY).
> Xfree 4.3 from debian sarge doesn't crash but it's way too slow.
> Vanilla 2.6.10 works fine.

Can you post a dmesg, config and lspci for -mm2? I'm having trouble
figuring exactly the combination to mess it up..

Dave.
