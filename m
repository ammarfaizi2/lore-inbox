Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTGGWxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTGGWxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 18:53:09 -0400
Received: from holomorphy.com ([66.224.33.161]:11419 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264097AbTGGWxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 18:53:06 -0400
Date: Mon, 7 Jul 2003 16:08:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
Message-ID: <20030707230854.GE15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christian Axelsson <smiler@lanil.mine.nu>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057590519.12447.6.camel@sm-wks1.lan.irkk.nu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 05:08:39PM +0200, Christian Axelsson wrote:
> Ok, running fine with 2.5.74-mm2 but when I try to insert the nvidia
> module (with patches from www.minion.de applied) it gives 
> nvidia: Unknown symbol pmd_offset
> in dmesg. The vmware vmmon module gives the same error (the others wont
> compile but thats a different story).
> The nvidia module works fine under plain 2.5.74.

Could you send me the patches for the opensource bits of those in a
private reply?

Thanks.


-- wli
