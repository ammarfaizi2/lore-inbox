Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWEaBjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWEaBjc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWEaBjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:39:31 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:49582 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751528AbWEaBjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:39:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
Subject: Re: Thinkpad port replicator's PS/2 mouse port broken
Date: Tue, 30 May 2006 21:39:28 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200605271844.40763.kimmo.sundqvist@mbnet.fi>
In-Reply-To: <200605271844.40763.kimmo.sundqvist@mbnet.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605302139.28725.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 May 2006 11:44, Kimmo Sundqvist wrote:
> Hello
> 
> Booting Ubuntu with 2.6.12 kernel, the internal trackpoint and the external 
> mouse connected to the port replicator's mouse port work fine. Booting Gentoo 
> with 2.6.14 kernel, only the internal mouse (trackpoint) works. It produces 
> output to /dev/psaux and /dev/input/mice, whereas the mouse connected to the 
> port replicator's mouse port does not.
>

This should be fixed in newer kernels. Please try 2.6.16 and let me know if
it still does not work.

-- 
Dmitry
