Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbUAEMq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUAEMq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:46:28 -0500
Received: from codepoet.org ([166.70.99.138]:44929 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S264472AbUAEMq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:46:26 -0500
Date: Mon, 5 Jan 2004 05:46:26 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.24-rc1
Message-ID: <20040105124626.GA25767@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0401051003341.1188@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0401051003341.1188@logos.cnet>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 05, 2004 at 10:18:35AM -0200, Marcelo Tosatti wrote:
> 
> 
> This release fixes a few critical problems in 2.4.23, including fixes
> for two security bugs.
> 
> Upgrade is recommended.

How about also fixing the rt_sigprocmask syscall?
    http://www.ussg.iu.edu/hypermail/linux/kernel/0312.3/1247.html

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
