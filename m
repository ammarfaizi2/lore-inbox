Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932621AbWBYE1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWBYE1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbWBYE1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:27:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21923 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932621AbWBYE1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:27:36 -0500
Date: Fri, 24 Feb 2006 23:27:29 -0500
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: multimedia keys on dell inspiron 8200s.
Message-ID: <20060225042729.GB7851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060224014947.GA17397@redhat.com> <200602242257.54062.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242257.54062.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 10:57:53PM -0500, Dmitry Torokhov wrote:
 > On Thursday 23 February 2006 20:49, Dave Jones wrote:
 > > We've been carrying this patch in Fedora for way too long.
 > > So long, I've forgotten a lot of the history.
 > > 
 > > Aparently, it makes multimedia buttons on Dell Inspiron 8200's
 > > produce keycodes.  The only reference to this I found was
 > > at http://linux.siprell.com/, but I don't know if that's its origin.
 > > 
 > 
 > Dave,
 > 
 > This patch was refused before. Any additional/non-standard mapping is
 > to be done in userspace (you need to properly adjust xorg.conf anyway):
 > 
 > http://bugzilla.kernel.org/show_bug.cgi?id=2817#c4

Ok, thanks, I'll make sure it gets dropped from the Fedora tree.

		Dave

