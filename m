Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSKEPFr>; Tue, 5 Nov 2002 10:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSKEPFr>; Tue, 5 Nov 2002 10:05:47 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:31454 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S262667AbSKEPFq>; Tue, 5 Nov 2002 10:05:46 -0500
Date: Tue, 5 Nov 2002 16:12:18 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-ac2, Sony PCG-C1MHP and Meye
Message-ID: <20021105151218.GA12610@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Manuel Serrano <Manuel.Serrano@sophia.inria.fr>,
	linux-kernel@vger.kernel.org
References: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 10:54:49AM +0100, Manuel Serrano wrote:

> Here is the description of my last problem with my Sony Picturebook 
> PCG-C1MHP computer. 
> 
> [1.] One line summary of the problem:
> =====================================
> 
> I can't load the meye module

This one is pretty immediate: you have a different model of the 
MotionEye camera than the previous (C1Vx) picturebook series.

The newer model is completly unsupported by the current driver.
Unless someone obtains the technical docs about this hardware,
there is little chance this will change.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
