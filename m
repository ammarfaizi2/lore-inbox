Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVKAOLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKAOLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVKAOLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:11:05 -0500
Received: from peabody.ximian.com ([130.57.169.10]:11961 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750797AbVKAOLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:11:04 -0500
Subject: Re: Kernel Badness 2.6.14-Git
From: Robert Love <rml@novell.com>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051101081433.GB28048@kroah.com>
References: <4362BFF1.3040304@linuxwireless.org>
	 <200510312221.13217.dtor_core@ameritech.net>
	 <20051101073530.GB27536@kroah.com>
	 <200511010258.14313.dtor_core@ameritech.net>
	 <20051101081433.GB28048@kroah.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 09:11:57 -0500
Message-Id: <1130854317.16163.52.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 00:14 -0800, Greg KH wrote:

> I don't have a problem with this, try it out and see what breaks :)

I don't mind moving the driver (as Greg suggested earlier) if needed,
but if Dmitry's idea to move input.o works, even better.

	Robert Love


