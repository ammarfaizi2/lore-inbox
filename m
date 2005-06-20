Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVFTTiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVFTTiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVFTTiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:38:14 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:37511 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261530AbVFTTe6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:34:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AGYFXGJWIT0fbTSfyEXs6Hz5J/rzEAiOUbGjyuNdb3gBcpGWwYy2PJCai30/zAVeYXHzPZbtK7czoAV0gQAW+GD5plAWj97to+xyug4p4DcIhfgx7nt3C/WE1po5WBSMp1ZplTszpkr09jv5lgXmtKDQLhPNKaNKN12tV0tLorw=
Message-ID: <105c793f050620123413840b81@mail.gmail.com>
Date: Mon, 20 Jun 2005 15:34:58 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: 2.6.12 udev hangs at boot
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200506202000.08114.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506181332.25287.nick@linicks.net> <42B6FBC7.5000900@pobox.com>
	 <20050620173411.GB15212@suse.de> <200506202000.08114.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/05, Nick Warne <nick@linicks.net> wrote:
> It appears the issue people are seeing is with Slack 10, which shipped with
> udev 0.26 - and I presume there was 'custom' rules Patrick had built in.
I was going to point this out, but Slack 10.1 seems to have shipped
with v0.50. While 10.1 would be thought to be an upgrade to 10.0, any
experienced Slackware user knows that upgrades are discourages. So,
you'd be very likely to find many Slackware 10 machines out there
(actually, I still have v9.1 on one of my laptops).

Anyway, something someplace obvious (e.g. a note in Changes in the
area where it tells what minimum package versions are needed) would be
helpful.

-Andy
