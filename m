Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTLAIA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 03:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLAIA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 03:00:28 -0500
Received: from holomorphy.com ([199.26.172.102]:43720 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261825AbTLAIA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 03:00:26 -0500
Date: Mon, 1 Dec 2003 00:00:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: James W McMechan <mcmechanjw@juno.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031201080020.GR8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>,
	James W McMechan <mcmechanjw@juno.com>,
	linux-kernel@vger.kernel.org
References: <20031130.131750.-1591395.3.mcmechanjw@juno.com> <20031201012126.GN8039@holomorphy.com> <20031201075824.GA6068@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201075824.GA6068@win.tue.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 05:21:26PM -0800, William Lee Irwin III wrote:
>> This is significantly different in nature from the 2.4 oops, since
>> 2.4 hit NULL and this pointer is total garbage.
>> Either it's a double bitflip or even worse is afoot.

On Mon, Dec 01, 2003 at 08:58:24AM +0100, Andries Brouwer wrote:
> This oops is completely understood. I was going to write to you
> yesterday evening, but then saw that Oleg Drokin already had
> written. Didnt you see his mail?

I'm sorry if my mail came out after Oleg's reply; I at least started
writing it before his arrived on my system.


-- wli
