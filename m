Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292017AbSBYRRR>; Mon, 25 Feb 2002 12:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292000AbSBYRRH>; Mon, 25 Feb 2002 12:17:07 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:17558 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S290109AbSBYRQw>; Mon, 25 Feb 2002 12:16:52 -0500
Date: Mon, 25 Feb 2002 18:15:31 +0100
To: Hans-Christian Armingeon <linux.johnny@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: knfsd not working in 2.4.18-rc4
Message-ID: <20020225181531.A2069@abulafia>
In-Reply-To: <16fLiV-0OqAvgC@fmrl03.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16fLiV-0OqAvgC@fmrl03.sul.t-online.com>
User-Agent: Mutt/1.3.23i
From: jan <jan.van.nunen@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 04:05:26PM +0100, Hans-Christian Armingeon wrote:
> Hi folks,
> kernel nfsd in 2.4.18-rc4 isn't working when started via the distribution's boot scripts, and I don't know, how to set it up manually. I don't blame the distro's script, but it is a SuSE 7.3.
> I think, it is a kernel issue.
> 2.4.17 worked, 2.4.18-rc4 was the first, who showed this misbehaviour.
> Maybe, it is final relevant?

Hi, well at my place the kernel nfsd is fine (2.4.18-rc4) and has been
for years now actually. I haven't heard of any of such problems with it,
so if I was you I would have a look at your init.d script.

Jan
