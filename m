Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263870AbTJEVsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263873AbTJEVsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:48:32 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:64530
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263870AbTJEVsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:48:31 -0400
Date: Sun, 5 Oct 2003 14:48:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Justin Hibbits <jrh29@po.cwru.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.xx
Message-ID: <20031005214833.GD1205@matchmail.com>
Mail-Followup-To: Justin Hibbits <jrh29@po.cwru.edu>,
	linux-kernel@vger.kernel.org
References: <83C51710-F764-11D7-BAB4-000A95841F44@po.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83C51710-F764-11D7-BAB4-000A95841F44@po.cwru.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 02:48:31PM -0400, Justin Hibbits wrote:
> (panic from 2.4.22, but panics also in 2.4.21)
> 
> This is what I get when I have high memory support and preempt enabled 
> in any 2.4 kernel.  High mem set to 4GB.  If I disable preempt, all 
> works just fine.  If you need more help, I'll keep this kernel around.

What exact kernel versions, with what prempt patch versions, and you didn't
run it through ksymoops, also mention those exact versions that this oops is
from.
