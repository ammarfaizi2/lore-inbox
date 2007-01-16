Return-Path: <linux-kernel-owner+w=401wt.eu-S932477AbXAPJR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbXAPJR2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbXAPJR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:17:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48732 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932477AbXAPJR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:17:27 -0500
From: Oliver Neukum <oneukum@suse.de>
Organization: Novell
To: "Jerome Lacoste" <jerome.lacoste@gmail.com>
Subject: Re: khubd taking 100% CPU after unproperly removing USB webcam
Date: Tue, 16 Jan 2007 10:17:24 +0100
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <5a2cf1f60701160110v68342cf5lbc364ffae568cd1@mail.gmail.com>
In-Reply-To: <5a2cf1f60701160110v68342cf5lbc364ffae568cd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701161017.25054.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 16. Januar 2007 10:10 schrieb Jerome Lacoste:
> Hi,
> 
> I unplugged my (second) webcam, forgotting to stop ekiga, and khubd is
> now taking 100% CPU.

You might start with mentioning which kind of camera your second webcam is.

	Oliver
