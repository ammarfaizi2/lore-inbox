Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbSLTCeK>; Thu, 19 Dec 2002 21:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267740AbSLTCeK>; Thu, 19 Dec 2002 21:34:10 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:57096
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267739AbSLTCeK>; Thu, 19 Dec 2002 21:34:10 -0500
Subject: Re: [BENCHMARK] scheduler tunables with contest - prio_bonus_ratio
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3E0263EA.2BB9C89@digeo.com>
References: <200212200850.32886.conman@kolivas.net>
	 <1040337982.2519.45.camel@phantasy>  <3E0253D9.94961FB@digeo.com>
	 <1040341293.2521.71.camel@phantasy>  <3E0263EA.2BB9C89@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040352135.2645.97.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 19 Dec 2002 21:42:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 19:27, Andrew Morton wrote:

> Prefixing all the names with "tune_" would suit, too.

I have no problem with this.  Keeping the names in all caps rings
"preprocessor define" to me, which in fact they are - but only insomuch
as they point to a real variable.  So I dislike that.

Personally I like them as normal variable names... don't you do the same
in the VM code as well?  But tune_foo is fine..

	Robert Love

