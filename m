Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTEUM2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 08:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTEUM2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 08:28:14 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:3982 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262073AbTEUM2N (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 21 May 2003 08:28:13 -0400
Date: Wed, 21 May 2003 13:45:27 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Hadmut Danisch <hadmut@danisch.de>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: speechless 2.5.69 kernel?
Message-ID: <20030521124522.GA5581@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hadmut Danisch <hadmut@danisch.de>, Linux-Kernel@vger.kernel.org
References: <20030521103713.GA5863@danisch.de> <20030521112115.GA3991@suse.de> <20030521123001.GA7884@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521123001.GA7884@danisch.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 02:30:01PM +0200, Hadmut Danisch wrote:
 > On Wed, May 21, 2003 at 12:21:15PM +0100, Dave Jones wrote:
 > > First make sure your .config contains
 > > CONFIG_INPUT=y, CONFIG_VT=y and CONFIG_VT_CONSOLE=y
 > > 
 > > if they do already, then.. if you have CONFIG_VIDEO_SELECT=y
 > > try turning that off.
 > 
 > Thanks for the hint, but it didn't help. :-(

tried booting with acpi=off ?
Try disabling framebuffer if you have it compiled in.

		Dave

