Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265776AbUHFKqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265776AbUHFKqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUHFKqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:46:46 -0400
Received: from holomorphy.com ([207.189.100.168]:4811 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265776AbUHFKqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:46:44 -0400
Date: Fri, 6 Aug 2004 03:46:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@vger.kernel.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806104630.GA17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roger Luethi <rl@hellgate.ch>, Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@vger.kernel.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806094037.GB11358@k3.hellgate.ch>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2004 21:11:52 -0400, Albert Cahalan wrote:
>> especially since WLI has fixes for some of the problems.

On Fri, Aug 06, 2004 at 11:40:37AM +0200, Roger Luethi wrote:
> I discussed this very issue with wli on linux-mm about a year ago. proc
> file and documentation are still broken. So what's wrong with doing
> something about it?

So now what, you want me to do yet another forward port of
linux-2.4.9-statm-B1.diff?


-- wli
