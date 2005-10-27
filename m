Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVJ0Ks7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVJ0Ks7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 06:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVJ0Ks7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 06:48:59 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:53361 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbVJ0Ks6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 06:48:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=b1j+xLV6fVMJx+7OujOCIM7RCbL6E8UG0UYQZ1wNFy3Ww/+USQxrAYDi9s21DLXDSLN7fYdxgADvDIrTqgz5AT28ap9EkXbsm5lrdENXEAPnvTJeh7fVUH3yKg2bT+7fR1Vwo7uDDnGHeGCIG/RfchMKCQxoai8FSAvH/h3D1Gk=
Date: Thu, 27 Oct 2005 12:48:46 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, rajesh.shah@intel.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051027124846.d789b53b.diegocg@gmail.com>
In-Reply-To: <20051026205038.26a1c333.pj@sgi.com>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
	<20051026205038.26a1c333.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 26 Oct 2005 20:50:38 -0700,
Paul Jackson <pj@sgi.com> escribió:

> It looks like Linus started the git history at 2.6.12-rc2.
> 
>   Could someone clue me in on how to find Linux history BG (before-git)?
> 
> Since bk no longer works for me, I have no idea how to access any
> history prior to about 2.6.12-rc2.  Ugh.

Linus put the old BK history (2.5.0 - 2.6.12-rc2) in:
http://kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git

