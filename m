Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVIQCeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVIQCeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 22:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIQCeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 22:34:24 -0400
Received: from peabody.ximian.com ([130.57.169.10]:20357 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750788AbVIQCeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 22:34:23 -0400
Subject: Re: R52 hdaps support?
From: Robert Love <rml@novell.com>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <432B7EE6.1040905@gmail.com>
References: <432B34D6.6010904@gmail.com> <1126911860.24266.1.camel@phantasy>
	 <432B7EE6.1040905@gmail.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 22:34:22 -0400
Message-Id: <1126924462.6939.2.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-16 at 22:26 -0400, Keenan Pepper wrote:

> OK, it's compiled and running, but how do I tell if it's inverted? The laptop is 
> on a horizontal surface and /sys/devices/platform/hdaps/position reads 
> (482,508). What does that mean?

Well, you can use the joystick device and see that the axises are
correct.

The other thing would be to grab the pivot program from the hdaps
package at http://www.kernel.org/pub/linux/kernel/people/rml/hdaps/ and
run it.

Tilting the laptop to you run and toward you should be (positive,
positive) I think.

	Robert Love


