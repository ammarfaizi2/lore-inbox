Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269379AbUJLAPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbUJLAPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJLAPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:15:41 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:43154 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269379AbUJLAPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:15:38 -0400
Message-ID: <35fb2e5904101117156b033f6b@mail.gmail.com>
Date: Tue, 12 Oct 2004 01:15:34 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041008130442.GE5551@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041008130442.GE5551@lkcl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004 14:04:42 +0100, Luke Kenneth Casson Leighton
<lkcl@lkcl.net> wrote:
> could someone kindly advise me on the location of some example code in
> the kernel which calls one of the userspace system calls from inside the
> kernel?

Hi Luke,

I enjoyed your recent talk at OxLUG in which you mentioned this
briefly. Could you please send me the source that you are working on
so that I can take a look and make suggestions if tha'ts useful - I
posted to the OxLUG list but you're not actually on it and although I
now have your address from someone, this post reminded me.

I've copied lkml for two reasons - a). Someone else might want to take
a look. b). I sat and talked with Luke for a while about this, he's
not a typical "I want to do stuff in the kernel I should be doing from
userspace" kind of person in my opinion (there might still be a better
way but until I see more what he's actually doing then I can't work
out what).

Jon.
