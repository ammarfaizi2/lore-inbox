Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUIXE2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUIXE2U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUIXE2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:28:20 -0400
Received: from holomorphy.com ([207.189.100.168]:53980 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267176AbUIXE2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:28:19 -0400
Date: Thu, 23 Sep 2004 21:28:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, alexn@telia.com, linux-kernel@vger.kernel.org
Subject: Re: lockmeter in 2.6.9-rc2-mm2
Message-ID: <20040924042807.GU9106@holomorphy.com>
References: <41539FC1.7040001@sgi.com> <20040923212106.7a89b3af.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923212106.7a89b3af.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Bryant <raybry@sgi.com> wrote:
>> Does the x86_64 stuff compile now?

On Thu, Sep 23, 2004 at 09:21:06PM -0700, Andrew Morton wrote:
> yup.  I do regular x86 and x86_64 allfooconfig builds.  I'd do so on
> sparc64/ppc64/ia64 too, if they had a chance of compiling :(

All it takes is grunt work to fix these; so how badly do you want them
fixed?


-- wli
