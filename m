Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTLKCKi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbTLKCKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:10:38 -0500
Received: from holomorphy.com ([199.26.172.102]:7396 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261875AbTLKCKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:10:37 -0500
Date: Wed, 10 Dec 2003 18:10:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-1
Message-ID: <20031211021031.GW8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20031209233523.GS8039@holomorphy.com> <Pine.LNX.4.58.0312091859330.2313@montezuma.fsmlabs.com> <br8i18$v8s$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <br8i18$v8s$1@gatekeeper.tmr.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, William Lee Irwin III wrote:
>|> Bill Davidsen reported an issue where compiled kernel images aren't
>|> properly distinguished from mainline kernels' by installation scripts.
>|> The following patch should resolve this:

Zwane Mwaikambo  <zwane@arm.linux.org.uk> wrote:
>| Argh, i've been screaming about this for ages...

On Thu, Dec 11, 2003 at 01:42:00AM +0000, bill davidsen wrote:
> Look, I'm a big boy now, I should be smart enough to *check* this,
> because every once in a while other people (you know who you are) do it
> too. My fault, I just noted it because other people may not be backed up
> as well as I am and shoot their only working kernel.

You don't have to run into it to report it. =) At any rate, I hope it does
prevent confusion elsewhere.


-- wli
