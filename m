Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWF0TTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWF0TTu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWF0TTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:19:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932542AbWF0TTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:19:48 -0400
Date: Tue, 27 Jun 2006 15:19:03 -0400
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Brad Campbell <brad@wasp.net.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion in	-mm
Message-ID: <20060627191903.GJ7914@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Brad Campbell <brad@wasp.net.au>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	suspend2-devel@lists.suspend2.net
References: <200606270147.16501.ncunningham@linuxmail.org> <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627190323.GA28863@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627190323.GA28863@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 09:03:24PM +0200, Pavel Machek wrote:

 > uswsusp already uses normal I/O ... and that is asynchronous.

Errm, no. it isn't.

		Dave

-- 
http://www.codemonkey.org.uk
