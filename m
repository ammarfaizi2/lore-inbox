Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSDXSC6>; Wed, 24 Apr 2002 14:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312480AbSDXSC5>; Wed, 24 Apr 2002 14:02:57 -0400
Received: from ns0.seaman.net ([168.215.64.186]:2570 "EHLO ns0.seaman.net")
	by vger.kernel.org with ESMTP id <S312466AbSDXSC4>;
	Wed, 24 Apr 2002 14:02:56 -0400
Date: Wed, 24 Apr 2002 13:02:55 -0500
From: "Richard Seaman, Jr." <dick@seaman.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Implementation of FreeBSD's KSEs on Linux?
Message-ID: <20020424130255.B16243@seaman.org>
Mail-Followup-To: "Richard Seaman, Jr." <dick@seaman.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1019659701.449462.23147.nullmailer@bozar.algorithm.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 12:48:21AM +1000, Andre Pang wrote:
> Hi there,
> 
> Are there any current projects to implement kernel-scheduled
> entities (KSEs) on Linux?  They currently exist on FreeBSD, and
> seem like a really neat idea.  I

AFAIK, there is no functioning KSE code in any version of
FreeBSD, including the most recent -current version.  It
is planned, yes.  Last I heard they didn't think it would
even be ready for 5.0-RELEASE, currently anticipated this
fall.  Its quite a significant change to the kernel.

-- 
Richard Seaman, Jr.        email:    dick@seaman.org
5182 N. Maple Lane         phone:    262-367-5450
Nashotah WI 53058            fax:    262-367-5852
