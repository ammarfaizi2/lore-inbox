Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWBPGlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWBPGlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 01:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWBPGlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 01:41:13 -0500
Received: from natblindhugh.rzone.de ([81.169.145.175]:28641 "EHLO
	natblindhugh.rzone.de") by vger.kernel.org with ESMTP
	id S932170AbWBPGlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 01:41:12 -0500
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: Daniel Drake <dsd@gentoo.org>
Subject: Re: sky2 hangs with 2.6.16-rc3
Date: Thu, 16 Feb 2006 07:42:35 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200602151025.19655.woho@woho.de> <43F39A36.4070807@gentoo.org>
In-Reply-To: <43F39A36.4070807@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602160742.35162.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 22:16, Daniel Drake wrote:
> Hi Wolfgang,
>
> Wolfgang Hoffmann wrote:
> > I'm seeing reproducable hangs with the new sky2 of 2.6.16-rc3 on my
> > Marvel 88E8053.
>
> You should send your experiences and information to Stephen Hemminger
> (the driver author) while CC'ing the netdev list. It is also preferable
> to attach things uncompressed.
>
> Daniel

Thanks for the advice, Daniel.
I've now done so, and filed #6084 to kernel bugzilla, uncompressed attachments 
there.

Wolfgang
