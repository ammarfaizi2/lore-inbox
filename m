Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUADMeN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265461AbUADMeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:34:13 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:8883 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265452AbUADMeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:34:12 -0500
Date: Sun, 4 Jan 2004 13:33:58 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040104123358.GB24913@louise.pinerecords.com>
References: <200401041227.i04CReNI004912@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401041227.i04CReNI004912@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-04 2004, Sun, 13:27 +0100
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> IOW, don't lie to the compiler and pretend P-M == P4
> with that -march=pentium4.

What do you recommend to use as march then?  There is
no pentiumm subarch support in gcc yet;  I was convinced
p4 was the closest match.

-- 
Tomas Szepe <szepe@pinerecords.com>
