Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937842AbWLGAjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937842AbWLGAjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937846AbWLGAjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:39:08 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:35911 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937844AbWLGAjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:39:05 -0500
Subject: Re: 2.6.19-rt3: compilation failure
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200612070028.kB70S9oT018500@turbo.physics.adelaide.edu.au>
References: <200612070028.kB70S9oT018500@turbo.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 16:39:02 -0800
Message-Id: <1165451943.30279.2.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-07 at 10:58 +1030, Jonathan Woithe wrote:
> Upon an attempt to compile 2.6.19-rt3 I encountered the following compile
> error:
> 

This was fix in -rt5 or 6 I think . The !PREEMPT_RT case. Current
version is -rt7

http://people.redhat.com/~mingo/realtime-preempt/patch-2.6.19-rt7

Daniel

