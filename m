Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTLaPVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbTLaPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:21:21 -0500
Received: from holomorphy.com ([199.26.172.102]:58053 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265165AbTLaPVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:21:19 -0500
Date: Wed, 31 Dec 2003 07:20:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paolo Ornati <ornati@lycos.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 [resend]
Message-ID: <20031231152052.GR27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paolo Ornati <ornati@lycos.it>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <200312311434.17036.ornati@lycos.it> <20031231150607.GQ27687@holomorphy.com> <200312311619.27812.ornati@lycos.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312311619.27812.ornati@lycos.it>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 December 2003 16:06, you wrote:
>> What io scheduler are you using? Or, could you post /var/log/dmesg?

On Wed, Dec 31, 2003 at 04:19:27PM +0100, Paolo Ornati wrote:
> "dmesg" and "config" attached.

Could you try this with elevator=deadline?


-- wli
