Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWGLQFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWGLQFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGLQFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:05:38 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:62660 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751446AbWGLQFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:05:37 -0400
Subject: Re: Fix prctl privilege escalation (CVE-2006-2451)
From: Marcel Holtmann <marcel@holtmann.org>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1152720258.4457.7.camel@localhost.localdomain>
References: <1152702720.14173.9.camel@localhost>
	 <1152720258.4457.7.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 18:05:53 +0200
Message-Id: <1152720353.14173.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabor,

> Already fixed since 07/06/2006:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.17.y.git;a=commit;h=0af184bb9f80edfbb94de46cb52e9592e5a547b0
> http://www.kernel.org/git/?p=linux/kernel/git/stable/linux-2.6.17.y.git;a=commitdiff;h=0af184bb9f80edfbb94de46cb52e9592e5a547b0;hp=52cbb7b78994ea3799f1bbb8c03bce1e2f72a271

it is fixed in the stable tree, but it is not fixed upstream. It happens
that security fixes go into the stable tree, before the enter upstream.

Regards

Marcel


