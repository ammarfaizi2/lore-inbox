Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269969AbTGaVyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTGaVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:54:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52732 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270530AbTGaVyI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:54:08 -0400
Subject: Re: [PATCH] O11int for interactivity
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Szonyi Calin <sony@etc.utt.ro>, kernel@kolivas.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030731213846.GF15452@holomorphy.com>
References: <200307301038.49869.kernel@kolivas.org>
	 <200307301055.23950.kernel@kolivas.org>
	 <200307301108.53904.kernel@kolivas.org>
	 <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
	 <20030731213846.GF15452@holomorphy.com>
Content-Type: text/plain
Message-Id: <1059688907.931.306.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 15:01:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 14:38, William Lee Irwin III wrote:

> If you could stop both the vmstat and the readprofile loop shortly
> after the skip (not _too_ shortly, at least 1 second after it) I'd be
> much obliged.

Just an FYI, Szonyi, you will need to boot the kernel with profile=n
where n is some number like 5, in order to use readprofile.

	Robert Love


