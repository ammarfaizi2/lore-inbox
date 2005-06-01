Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFAKFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFAKFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 06:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVFAKFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 06:05:03 -0400
Received: from god.demon.nl ([83.160.164.11]:40205 "EHLO god.dyndns.org")
	by vger.kernel.org with ESMTP id S261170AbVFAKEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 06:04:49 -0400
Date: Wed, 1 Jun 2005 12:04:43 +0200
From: Henk <Henk.Vergonet@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-ID: <20050601100443.GA22825@god.dyndns.org>
References: <20050531220738.GA21775@god.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531220738.GA21775@god.dyndns.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Benedict wrote:

> I don't know if a real API is really needed for that.

No we don't. My term API was confusing, it's only a small include file
and some standardisation.

see the attached patch file

> However, the principle could be reversed by using a 7-segment "font", a
> mapping function and an initializer which specifies which bit belongs to
> which bar of the 7-segment display...

That's exactly what this is, see the attached patch file.

Regards,


Henk

PS please CC me as I am not on the list.


