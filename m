Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbTKEJXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 04:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTKEJXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 04:23:48 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:26621 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262781AbTKEJXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 04:23:48 -0500
Date: Wed, 5 Nov 2003 10:23:39 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: "\"Alistair J Strachan\" " <alistair@devzero.co.uk>,
       "\"Arjan van de Ven\" " <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Message-ID: <20031105102339.D29912@devserv.devel.redhat.com>
References: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru>; from arvidjaar@mail.ru on Wed, Nov 05, 2003 at 10:10:14AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 10:10:14AM +0300, "Andrey Borzenkov"  wrote:

> Mandrake and AFAIK RedHat ship single 2.4 kernel source that allos building

the 2.6 rpms I'm working on don't do this anymore. What Dave Jones will do
in his RPMs I don't know.

