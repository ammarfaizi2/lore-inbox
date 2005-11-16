Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932595AbVKPKFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbVKPKFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 05:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbVKPKFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 05:05:46 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:36071 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932595AbVKPKFq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 05:05:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Yp1eyrZJAJF64//kLP5c1z5ojfo2Kq8iPHJoQ/uEYpA6PTAEuVn7OqZjltI8PIKM/HajxzfT6hyQkPgmoodh/tIfhmDLt4/VAsHoXjnb8ffZEGOUseAbLccFe7fLoVVTz4qZ59+9G122+QB7JlizesYsaEqUg4kEUEpFBWdu5MY=
Message-ID: <84144f020511160205y27c494a2mee464987d3ef773e@mail.gmail.com>
Date: Wed, 16 Nov 2005 12:05:43 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Subject: Re: Linuv 2.6.15-rc1
Cc: Zhu Yi <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
In-Reply-To: <20051116094551.GA23140@gemtek.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	 <4378980C.7060901@ens-lyon.fr> <20051114162942.5b163558.akpm@osdl.org>
	 <20051115100519.GA5567@gemtek.lt> <20051115115657.GA30489@gemtek.lt>
	 <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
	 <20051115140023.GB9910@gemtek.lt>
	 <1132120145.18679.12.camel@debian.sh.intel.com>
	 <20051116094551.GA23140@gemtek.lt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/16/05, Zilvinas Valinskas <zilvinas@gemtek.lt> wrote:
> Please see : http://www.gemtek.lt/~zilvinas/dumps/trace
>
> This time I didn't see oops printed again :( Don't understand why,
> although I have managed to capture SysRQ-T output - see URL above.
> Kernel has been updated this morning to revision:

No firmware loading errors either? Please try out the patch I sent you
earlier _if_ the firmware still fails to load.

Could you please post your lspci -v output?

                          Pekka
