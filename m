Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTBDTSP>; Tue, 4 Feb 2003 14:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTBDTSP>; Tue, 4 Feb 2003 14:18:15 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:39108 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267429AbTBDTSO>; Tue, 4 Feb 2003 14:18:14 -0500
Date: Tue, 4 Feb 2003 20:16:40 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.5.59] cpufreq: support for "target frequency governors"
Message-ID: <20030204191640.GA20126@brodo.de>
References: <20030203221443.GA1420@brodo.de> <20030204131348.C16744@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204131348.C16744@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2003 at 01:13:48PM +0100, Dave Jones wrote:
> On Mon, Feb 03, 2003 at 11:14:43PM +0100, Dominik Brodowski wrote:
>  > This patch adds support for "cpufreq governors". 
>  > <snip excellent description of governors>
> 
> Could you add your descriptions to Documentation/cpufreq/ too?
> The cpufreq interface has come quite a way since the original version
> and is getting quite complex. Keeping documentation around for it
> can only be a good thing, and as you've already written it.. 8-)

A very large documentation-update patch (37K) is in my queue, but as 
long as the corresponding code isn't in the kernel completely, it makes 
no sense in update the documentation :)

	Dominik
