Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJMSTu>; Sun, 13 Oct 2002 14:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSJMSTu>; Sun, 13 Oct 2002 14:19:50 -0400
Received: from are.twiddle.net ([64.81.246.98]:19376 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S261573AbSJMSTt>;
	Sun, 13 Oct 2002 14:19:49 -0400
Date: Sun, 13 Oct 2002 11:25:11 -0700
From: Richard Henderson <rth@twiddle.net>
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, wli@holomorphy.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [lart] /bin/ps output
Message-ID: <20021013112511.A2026@twiddle.net>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, anton@samba.org,
	wli@holomorphy.com, haveblue@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20021012040959.GE7050@krispykreme> <20021011.235329.116353173.davem@redhat.com> <20021012131501.C25740@twiddle.net> <20021012.232744.10131509.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012.232744.10131509.davem@redhat.com>; from davem@redhat.com on Sat, Oct 12, 2002 at 11:27:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 11:27:44PM -0700, David S. Miller wrote:
> Good idea, well on SMP it can be marked throw-away (ie. __init_data).

Or you could use it for cpu0.


r~
