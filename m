Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTJTU7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTJTU7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:59:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:37506 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262746AbTJTU7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:59:34 -0400
Subject: Re: RH7.3 can't compile 2.6.0-test8
From: Paul Larson <plars@linuxtestproject.org>
To: Marco Roeland <marco.roeland@xs4all.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20031020164349.GA12986@localhost>
References: <0c1101c396f4$00bfeaf0$24ee4ca5@DIAMONDLX60>
	<3F93EABF.5000805@g-house.de>  <20031020164349.GA12986@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Oct 2003 15:58:58 -0500
Message-Id: <1066683539.8376.21.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 11:43, Marco Roeland wrote:
> No, you just need to upgrade binutils to version 2.12 or higher, as mentioned
> in Documentation/Changes. The gcc version is fine.
Apparently that's not quite enough.  I have a machine on binutils
2.12.90.0.9 and I'm still getting the same failure.

-Paul Larson


