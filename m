Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUG2XxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUG2XxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUG2XxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 19:53:12 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:9624 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S263204AbUG2XxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 19:53:09 -0400
X-Sender-Authentication: net64
Date: Fri, 30 Jul 2004 01:53:07 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to increase max number of groups per uid ?
Message-Id: <20040730015307.71df3cc6.skraw@ithnet.com>
In-Reply-To: <20040729163407.02bb2dd6.akpm@osdl.org>
References: <20040729193106.43d4c515.skraw@ithnet.com>
	<20040729163407.02bb2dd6.akpm@osdl.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 16:34:07 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Stephan von Krawczynski <skraw@ithnet.com> wrote:
> >
> > is there a simple way in either 2.4 or 2.6 to get a lot more than 32 groups
> > per uid?
> 
> 2.6 kernels support up to 65536 groups per user.

Then this feature didn't seem to make it in the core utils.
On a 2.6-based SuSE 9.1 "groups" (which is in fact "id") lists exactly 32.

What about other distros?

Regards,
Stephan
