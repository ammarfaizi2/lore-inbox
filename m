Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVCUDWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVCUDWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVCUDWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:22:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261529AbVCUDWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:22:23 -0500
Date: Sun, 20 Mar 2005 22:22:21 -0500
From: Dave Jones <davej@redhat.com>
To: William Beebe <wbeebe@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Message-ID: <20050321032221.GA29664@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	William Beebe <wbeebe@gmail.com>, linux-kernel@vger.kernel.org
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0716e9f05032019064c7b1cec@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 10:06:57PM -0500, William Beebe wrote:

 > Is this really a kernel issue? Or is there a better way in userland to
 > stop this kind of crap?

man ulimit

		Dave

