Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278346AbRJSInA>; Fri, 19 Oct 2001 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278348AbRJSImv>; Fri, 19 Oct 2001 04:42:51 -0400
Received: from toad.com ([140.174.2.1]:26386 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278346AbRJSImd>;
	Fri, 19 Oct 2001 04:42:33 -0400
Message-ID: <3BCFE7A7.4C06334C@mandrakesoft.com>
Date: Fri, 19 Oct 2001 04:43:20 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <21727.1003480312@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Will you want modutils support for this new struct?  If so it needs
> a version field.

For struct device?  Um, no, we don't need modutils support for it.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
