Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSGLMxb>; Fri, 12 Jul 2002 08:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSGLMxa>; Fri, 12 Jul 2002 08:53:30 -0400
Received: from ns.suse.de ([213.95.15.193]:7954 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315923AbSGLMx2>;
	Fri, 12 Jul 2002 08:53:28 -0400
Date: Fri, 12 Jul 2002 14:56:16 +0200
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020712145616.F14671@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20020711230222.GA5143@kroah.com> <20020711231804.GA5635@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020711231804.GA5635@kroah.com>; from greg@kroah.com on Thu, Jul 11, 2002 at 04:18:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2002 at 04:18:05PM -0700, Greg KH wrote:
 > And here's the version against the 2.5.25-dj1 tree.  Dave, will you
 > please add it to your tree?

Done. Along with some small CodingStyle changes (to existing code,
not anything you added).

Thanks for doing this, it's a big improvement.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
